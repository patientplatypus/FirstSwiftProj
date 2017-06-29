
var mongoose = require('mongoose');

var schema = new mongoose.Schema({
  username: { type: String, required: false },
  realname: { type: String, required: false },
  age: { type: Number, required: false },
  gender: { type: String, required: false },
  favoritecolor: { type: String, required: false },
  favoritefood: {type: String, required: false},
  password: {type: String, required: false },
  profileIMGURL: {type: String, required: false },
  profileIMGTITLE: {type: String, required: false },
});

var Userprofile = mongoose.model('Userprofile', schema);

module.exports = Userprofile;

//username, realname, age, gender,favoritefood,favoritecolor
