import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/component.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      builder: (BuildContext context, NewsStates state) {
        var list = NewsCubit.get(context).search;
        return  Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultTextFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      onChange: (value){
                          NewsCubit.get(context).getSearch(value);
                      },
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      label: 'Search',
                      prefix: Icons.search),
                ),
                Expanded(
                    child: articleBuilder(list,
                        context, NewsCubit.get(context).isDark,
                      isSearch: true
                    ))
              ],
            ),
          ),
        );
      },
      listener: (BuildContext context, NewsStates state) {  },

    );
  }
}
