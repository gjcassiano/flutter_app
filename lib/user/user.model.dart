
// this model need be equals the model from server
class User {
    final String id;
    final String firstName;
    final String email;
    
    // constructor
    User({this.id, this.firstName, this.email});
    
    factory User.fromJson(Map<String, dynamic> json) {
        print(json);
        return User(
            id: json['id'],
            firstName: json['firstname'],
            email: json['email'],
        );
    }
}
