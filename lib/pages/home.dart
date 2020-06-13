import 'package:choosepad/bloc/recipe/recipe_list_bloc.dart';
import 'package:choosepad/bloc/recipe/recipe_list_state.dart';
import 'package:choosepad/data/recipe_ogp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ToggleSplashNotification extends Notification {}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeListBloc = BlocProvider.of<RecipeListBloc>(context);
    // final authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    // final signInBloc = BlocProvider.of<SignInBloc>(context);

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
              builder: (context, AsyncSnapshot<List<RecipeOgp>> snapshot) {
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
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: ListTile(
                        leading: Image.network(
                          event.image,
                          fit: BoxFit.fitWidth,
                        ),
                        title: Text(
                          event.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          event.description,
                        ),
                        onTap: () {
                          _launchURL(event.url);
                        },
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

  dynamic _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
