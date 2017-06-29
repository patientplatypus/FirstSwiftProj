var express = require('express');
var router = express.Router();
var axios = require('axios');
var Userprofile = require('../models/userprofile');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

//Imgur Client Id
//4d9396cdcf5d6da
//Imgur Client Secret
//1f636a26d5a0693a4ff923cf350a315cde6b61c9

// $.ajax({
//       headers: {
//     "Authorization": 'Client-ID xxxxxxxxxxxx'
//   },
//     url: 'https://api.imgur.com/3/gallery/search/time/1/?q=cat',
//     success:function(data){
//       console.log(data)
//     }
//   })


// https://api.imgur.com/3/gallery/authorize?client_id=4d9396cdcf5d6da&search?q={search term}
router.post('/getimages', (req,res,next)=>{
  console.log('successfully got to /getimages backend :P');
  console.log('the value of the search query is ', req.body.search);
  var url = 'https://api.imgur.com/3/gallery/search?q='+req.body.search;


  search = req.body.search;
  clientId = "4d9396cdcf5d6da";

  axios({
      method: 'get',
      url: 'https://api.imgur.com/3/gallery/search?q=' + search,
      headers: { 'authorization': 'Client-ID ' + clientId }
  }).then((response)=>{
      console.log('YATA from axios to imgur');
      console.log(response.data);
      res.json(response.data)
  }).catch((error)=>{
      console.log('Fail from axios request to imgur');
      console.log(error);
      res.json({'OHNOES':'NOOOOYATA from getimages'});
  });
});

router.post('/saveprofile', (req,res,next)=>{
  console.log("successfully got to /saveprofile on backend");
  var updated = 0;
  var loopcounter = 0;


    Userprofile.find({},(err,posts)=>{
      var loopcount = posts.length
      posts.forEach(post=>{

        console.log("loopcount: ", loopcount, "loopcounter: ", loopcounter);

        if (post.username === req.body.username && updated === 0){
          updated = 1;
          post.realname = req.body.realname || post.realname
          post.age = req.body.age || post.age
          post.gender = req.body.gender || post.gender
          post.favoritefood = req.body.favoritefood || post.favoritefood
          post.favoritecolor = req.body.favoritecolor || post.favoritecolor
          post.save((err)=>{
             if (err){
                console.log('error saving update: ', err);
                res.json({'Error':'error in update from /saveprofile'});
                // break
                return
             }else{
               console.log('success saving update');
               res.json({'YATA':'updated profile successfully in /saveprofile'})
               //  break
               return
             }
          });
        }

        if (loopcount === loopcounter+1 && updated === 0){
          updated = 1;
          var profile = new Userprofile({
            username: req.body.username,
            realname: req.body.realname,
            age: req.body.age,
            gender: req.body.gender,
            favoritefood: req.body.favoritefood,
            favoritecolor: req.body.favoritecolor
          });

          profile.save(function(err,post){
            if (err) {return next(err)}
            res.json({'YATA': 'saved new profile successfully in /saveprofile'})
            console.log('new profile successfully saved');
            // break
            return
          });
        }


        loopcounter += 1;

      });
    });
});

router.post('/login', (req, res, next)=>{
  console.log("successfully got to /login on backend");
  var updated = 0;
  var loopcounter = 0;
    Userprofile.find({},(err,posts)=>{
      var loopcount = posts.length
      posts.forEach(post=>{
        if (post.username === req.body.username && post.password === req.body.password && updated === 0){
          updated = 1;
          res.json({post});
        }
        if (loopcount === loopcounter+1 && updated === 0){
          updated = 1;
          res.json({"loginFAIL": "u.sux"});
        }
        loopcounter += 1;
      });
    });
});

router.post('/signup', (req, res, next)=>{
  console.log("successfully got to /signup on backend");
  console.log('value of req.body.password is ', req.body.password);
  var updated = 0;
  var loopcounter = 0;
    Userprofile.find({},(err,posts)=>{
      var loopcount = posts.length
      posts.forEach(post=>{
        if (post.username === req.body.username && updated === 0){
          updated = 1;
          res.json({"cantsignup":"someonehasthatname"});
        }
        if (loopcount === loopcounter+1 && updated === 0){
          updated = 1;
          var profile = new Userprofile({
            username: req.body.username,
            password: req.body.password
          });
          profile.save(function(err,post){
            if (err) {return next(err)}
            res.json({"signupYATA": "huzzah"});
            console.log('new profile successfully saved');
            // break
            return
          });
        }
        loopcounter += 1;
      });
    });
});


module.exports = router;
