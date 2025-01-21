import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maya_tech_exam/app.dart';
import 'package:maya_tech_exam/domains/datasource/user_datasource.dart';
import 'package:maya_tech_exam/domains/networks/network.dart';
import 'package:maya_tech_exam/domains/repositories/user_repository.dart';
import 'package:maya_tech_exam/states/send_money_bloc/send_money_bloc.dart';
import 'package:maya_tech_exam/states/sign_in_bloc/sign_in_bloc.dart';
import 'package:maya_tech_exam/states/transactions/transactions_bloc.dart';
import 'package:maya_tech_exam/states/user_details/user_details_bloc.dart';
import 'package:maya_tech_exam/theme/theme_cubit.dart';

void main() {
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),

        ///
        /// Data sources
        ///
        RepositoryProvider<UserDataSource>(
          create: (context) => UserDataSource(context.read<NetworkManager>()),
        ),

        ///
        /// Repositories
        ///,
        RepositoryProvider<UserRepository>(
          create: (context) => UserDefaultRepository(
            dataSource: context.read<UserDataSource>(),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          ///bloc features
          BlocProvider<SignInBloc>(
            create: (context) => SignInBloc(context.read<UserRepository>()),
          ),
          BlocProvider<SendMoneyBloc>(
            create: (context) => SendMoneyBloc(context.read<UserRepository>()),
          ),
          BlocProvider<TransactionsBloc>(
            create: (context) => TransactionsBloc(context.read<UserRepository>()),
          ),
          BlocProvider<UserDetailsBloc>(
            create: (context) => UserDetailsBloc(context.read<UserRepository>()),
          ),
          ///bloc theme
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: MaterialApp(home: MainScreenApp(),),
      )));
}

