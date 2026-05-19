import 'package:bloc_todo_app/data/network/api_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(GetPostsEvent());
    });
    context.read<HomeBloc>().add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<HomeBloc>().state.apiStatus);
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(GetProductsEvent());
        // return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.apiStatus == ApiStatus.loading) {

            } else if (state.apiStatus == ApiStatus.error) {
              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.products.message)));
            } else if (state.products.data?.isEmpty ?? false) {
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            // buildWhen: (current, previous) => false,
            builder: (context, state) {
              if (state.apiStatus == ApiStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.apiStatus == ApiStatus.error) {
                return ListView(
                  children: [
                    Center(child: Text('Error')),
                  ],
                );
              } else if (state.products.data?.isEmpty ?? false) {
                return Center(child: Text('No Products'));
              }
              return ListView.builder(
                itemCount: state.products.data?.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(40),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text(state.products.data?[index].title ?? ''),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
