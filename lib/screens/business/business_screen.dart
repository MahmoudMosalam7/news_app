import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';

import '../../shared/component.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (BuildContext context, NewsStates state) {
        var  list = NewsCubit.get(context).business;
        return articleBuilder(list,context,NewsCubit.get(context).isDark);
      },
      listener: (BuildContext context, NewsStates state) {  },
        );
  }
}
