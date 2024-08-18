import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';

import 'package:flutter/material.dart';
import 'package:news/network/local/cache_helper.dart';
import 'package:news/screens/business/business_screen.dart';
import 'package:news/screens/science/science_screen.dart';
import 'package:news/screens/sports/sports_screen.dart';

import '../network/remote/dio_helper.dart';
class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) =>  BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon:Icon(Icons.business),label: "Business" ),
    const BottomNavigationBarItem(icon:Icon(Icons.sports),label: "Sports" ),
    const BottomNavigationBarItem(icon:Icon(Icons.science),label: "Science" ),
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(NewsBottomNavBarState());
  }
  List<dynamic> business = [];
  void getBusiness(){
    emit(NewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'7401a19a03fa413bbd760fefd20c1958',
        }).then((value){
     // print(value.data.toString());
      business = value.data['articles'];
      emit(NewsBusinessSuccessState());
    }).catchError((error){
      emit(NewsBusinessErrorState(error.toString()));
    });
  }
  List<dynamic> sports = [];
  void getSports(){
    emit(NewsSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'7401a19a03fa413bbd760fefd20c1958',
        }).then((value){
      // print(value.data.toString());
      sports = value.data['articles'];
      emit(NewsSportsSuccessState());
    }).catchError((error){
      emit(NewsSportsErrorState(error.toString()));
    });
  }
  List<dynamic> science = [];
  void getScience(){
    emit(NewsScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'7401a19a03fa413bbd760fefd20c1958',
        }).then((value){
      // print(value.data.toString());
      science = value.data['articles'];
      emit(NewsScienceSuccessState());
    }).catchError((error){
      emit(NewsScienceErrorState(error.toString()));
    });
  }
  List<dynamic> search = [];
  void getSearch(String value){

    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'7401a19a03fa413bbd760fefd20c1958',
        }).then((value){
      // print(value.data.toString());
      search = value.data['articles'];
      emit(NewsSearchSuccessState());
    }).catchError((error){
      emit(NewsSearchErrorState(error.toString()));
    });
  }
  bool isDark = false;

  ThemeMode get appMode => isDark ? ThemeMode.dark : ThemeMode.light;
  void changeAppMode({bool? fromShared}){
    if(fromShared != null){

      isDark = fromShared;
      emit(NewsDarkModeState());
    }
    else{
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value){
        emit(NewsDarkModeState());
      });
    }

  }
}