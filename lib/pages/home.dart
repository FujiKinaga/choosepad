import 'package:choosepad/bloc/recipe/recipe_list_bloc.dart';
import 'package:choosepad/bloc/recipe/recipe_list_state.dart';
import 'package:choosepad/bloc/user/authentication_bloc.dart';
import 'package:choosepad/bloc/user/sign_in_bloc.dart';
import 'package:choosepad/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToggleSplashNotification extends Notification {}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeListBloc = BlocProvider.of<RecipeListBloc>(context);
    final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    final signInBloc = BlocProvider.of<SignInBloc>(context);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("ChoosePad"),
      ),
      body: BlocBuilder(
        bloc: recipeListBloc,
        builder: (context, RecipeListState state) {
          if (state is RecipeListInProgress) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is RecipeListSuccess) {
            return StreamBuilder(
              stream: state.recipeList,
              builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[Text("Failure")],
                    ),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final event = snapshot.data[index];

                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              event.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              event.description,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Image.network(
                                  event.imageUrl,
                                  fit: BoxFit.none,
                                  height: 128,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              },
            );
          }

          if (state is RecipeListFailure) {
            return Center(
              child: Text("Failure"),
            );
          }

          return Container();
        },
      ),
    );
  }
}
