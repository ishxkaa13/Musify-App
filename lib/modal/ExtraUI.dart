import 'package:flutter/material.dart';

//user register
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    _formKey.currentState.save();
  }

  String username;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Register",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'UserName'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    username = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter UserName!';
                    }
                    return null;
                  },
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'EmailAddress'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: false,
                  onSaved: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                MaterialButton(
                  onPressed: () async {
                    _submit();
                    Register data = await createUser(username, email);
                    log("${data.secretCode}");
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//user login
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String secretcode;
  bool _submit() {
    final isValid = _formKey.currentState.validate();
    log('${isValid}');
    if (!isValid) {
      return false;
    }

    _formKey.currentState.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Secret Code'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: true,
                  onSaved: (value) {
                    secretcode = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Secret Code';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      if (!_submit()) {
                        return;
                      }
                      log(secretcode);
                      await loginUser(secretcode);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPlaylistPage()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//create playlist
class AddPlaylistPage extends StatefulWidget {
  @override
  _AddPlaylistPageState createState() => _AddPlaylistPageState();
}

class _AddPlaylistPageState extends State<AddPlaylistPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var name;
  var secretCode;
  String list;
  String list1;
  List<String> _playlists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create playlists"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Create Playlist",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name of Playlist'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  onSaved: (value) {
                    name = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list1 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Playlist to create';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'SecretCode'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  onSaved: (value) {
                    secretCode = value;
                  },
                  onChanged: (e) {
                    setState(() {
                      list = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'User does not exist';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _playlists.add(list1);
                        print(">>> $_playlists");
                      });
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      } else {
                        return;
                      }
                      await createPlaylist(secretCode, name);
                      // log("${data.name}");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsersPage(
                                playlist: _playlists,
                              )));
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class UsersPage extends StatefulWidget {
  final List<String> playlist;

  const UsersPage({Key key, this.playlist}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // void _submit() {
  //   final isValid = _formKey.currentState.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Playlists",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemCount: widget.playlist.length,
                    itemBuilder: (BuildContext context, int x) {
                      return InkWell(
                        child: Container(
                          child: Card(
                              child: ListTile(
                                  title: Text(widget.playlist[0]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SongsPage()));
                                  })),
                        ),
                      );
                    }),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SongsPage extends StatefulWidget {
  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String list1;
  String list2;
  String list3;
  List<String> _songs = [];
  var name;
  var secretCode;
  var id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Songs"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Add Songs",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'secretCode'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: true,
                  onSaved: (value) {
                    secretCode = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list1 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Song to add';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Add Song'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: false,
                  onSaved: (value) {
                    name = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list2 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Song to add';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'playlist_id '),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: false,
                  onSaved: (value) {
                    id = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list3 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'id';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _songs.add(list2);
                        print(_songs);
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowSongsPage(song: _songs)));
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowSongsPage extends StatefulWidget {
  final List<String> song;

  const ShowSongsPage({Key key, this.song}) : super(key: key);

  @override
  State<ShowSongsPage> createState() => _ShowSongsPageState();
}

class _ShowSongsPageState extends State<ShowSongsPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // void _submit() {
  //   final isValid = _formKey.currentState.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Playlists",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemCount: widget.song.length,
                    itemBuilder: (BuildContext context, int x) {
                      return InkWell(
                        child: Container(
                          child: Card(
                              child: ListTile(
                                  title: Text(widget.song[x]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SongsPage()));
                                  })),
                        ),
                      );
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Thanks a lot.Got it, thanks!Thanks, I'll check it out.


@override
Widget build(BuildContext context) {
  return Container();
}
}


//user register
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    _formKey.currentState.save();
  }

  String username;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Register",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'UserName'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    username = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter UserName!';
                    }
                    return null;
                  },
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'EmailAddress'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: false,
                  onSaved: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                MaterialButton(
                  onPressed: () async {
                    _submit();
                    Register data = await createUser(username, email);
                    log("${data.secretCode}");
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//user login
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String secretcode;
  bool _submit() {
    final isValid = _formKey.currentState.validate();
    log('${isValid}');
    if (!isValid) {
      return false;
    }

    _formKey.currentState.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Login",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Secret Code'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: true,
                  onSaved: (value) {
                    secretcode = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Secret Code';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      if (!_submit()) {
                        return;
                      }
                      log(secretcode);
                      await loginUser(secretcode);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPlaylistPage()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//create playlist
class AddPlaylistPage extends StatefulWidget {
  @override
  _AddPlaylistPageState createState() => _AddPlaylistPageState();
}

class _AddPlaylistPageState extends State<AddPlaylistPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var name;
  var secretCode;
  String list;
  String list1;
  List<String> _playlists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create playlists"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Create Playlist",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name of Playlist'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  onSaved: (value) {
                    name = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list1 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Playlist to create';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'SecretCode'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  onSaved: (value) {
                    secretCode = value;
                  },
                  onChanged: (e) {
                    setState(() {
                      list = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'User does not exist';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _playlists.add(list1);
                        print(">>> $_playlists");
                      });
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                      } else {
                        return;
                      }
                      await createPlaylist(secretCode, name);
                      // log("${data.name}");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsersPage(
                                playlist: _playlists,
                              )));
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class UsersPage extends StatefulWidget {
  final List<String> playlist;

  const UsersPage({Key key, this.playlist}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // void _submit() {
  //   final isValid = _formKey.currentState.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Playlists",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemCount: widget.playlist.length,
                    itemBuilder: (BuildContext context, int x) {
                      return InkWell(
                        child: Container(
                          child: Card(
                              child: ListTile(
                                  title: Text(widget.playlist[0]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SongsPage()));
                                  })),
                        ),
                      );
                    }),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SongsPage extends StatefulWidget {
  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String list1;
  String list2;
  String list3;
  List<String> _songs = [];
  var name;
  var secretCode;
  var id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Songs"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Add Songs",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                //styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),

                //text input
                TextFormField(
                  decoration: InputDecoration(labelText: 'secretCode'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: true,
                  onSaved: (value) {
                    secretCode = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list1 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Song to add';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Add Song'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: false,
                  onSaved: (value) {
                    name = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list2 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Song to add';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'playlist_id '),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  obscureText: false,
                  onSaved: (value) {
                    id = value;
                    // log('${name}');
                  },
                  onChanged: (e) {
                    setState(() {
                      list3 = e;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'id';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      setState(() {
                        _songs.add(list2);
                        print(_songs);
                      });
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowSongsPage(song: _songs)));
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowSongsPage extends StatefulWidget {
  final List<String> song;

  const ShowSongsPage({Key key, this.song}) : super(key: key);

  @override
  State<ShowSongsPage> createState() => _ShowSongsPageState();
}

class _ShowSongsPageState extends State<ShowSongsPage> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  // void _submit() {
  //   final isValid = _formKey.currentState.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Playlists"),
        leading: Icon(Icons.filter_vintage),
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Playlists",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    itemCount: widget.song.length,
                    itemBuilder: (BuildContext context, int x) {
                      return InkWell(
                        child: Container(
                          child: Card(
                              child: ListTile(
                                  title: Text(widget.song[x]),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SongsPage()));
                                  })),
                        ),
                      );
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Thanks a lot.Got it, thanks!Thanks, I'll check it out.


@override
Widget build(BuildContext context) {
  return Container();
}
}
