var express = require('express');
var router = express.Router();
var axios = require('axios');

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
router.post('/getimages', function(req,res,next){
  console.log('successfully got to /getimages backend :P');
  console.log('the value of the search query is ', req.body.search);
  var url = 'https://api.imgur.com/3/gallery/search?q='+req.body.search;
  // axios.defaults.headers.common['Authorization'] = 'Client-ID 4d9396cdcf5d6da';

  // axios.get(url)
  // .then(function (response) {
  //   console.log('YATA from axios to imgur');
  //   console.log(response);
  //     res.json(response);
  // })
  // .catch(function (error) {
  //   console.log('Fail from axios request to imgur');
  //   console.log(error);
  //     res.json({'OHNOES':'NOOOOYATA from getimages'});
  // });


  search = req.body.search;
  clientId = "4d9396cdcf5d6da";

  axios({
      method: 'get',
      url: 'https://api.imgur.com/3/gallery/search?q=' + search,
      headers: { 'authorization': 'Client-ID ' + clientId }
  }).then(function(response) {
      console.log('YATA from axios to imgur');
      console.log(response.data);
      res.json(response.data)
  }).catch(function(error) {
      console.log('Fail from axios request to imgur');
      console.log(error);
      res.json({'OHNOES':'NOOOOYATA from getimages'});
  });




})





module.exports = router;
