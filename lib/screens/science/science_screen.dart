import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../shared/component.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      builder: (BuildContext context, NewsStates state) {

        var  list = NewsCubit.get(context).science;
        return articleBuilder(list,context,NewsCubit.get(context).isDark);
         },
      listener: (BuildContext context, NewsStates state) {  },
    );
  }
}
