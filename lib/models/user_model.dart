class UserModel{
  String? email;
  String? name;
  String? phone;
  String? password;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    this.image,
    this.cover,
    required this.bio,
    required this.isEmailVerified,
    required this.password,
});

  UserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
    password = json['password'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uId' : uId,
      'isEmailVerified' : isEmailVerified,
      'password' : password,
      'image' : image,
      'cover' : cover,
      'bio' : bio
    };
  }
}