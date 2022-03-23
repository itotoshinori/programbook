<template>
  <div id="app">
    <div class="main-box">
      
    </div>
    <br>
    <p style="text-align:center;"><a href="#" class="btn btn-success" onclick="history.back(-1);return false;">前のページに戻る</a></p>
    <span v-if="admin_status==true"><p style="text-align:center;"><Input /></p></span>
  </div>
  
</template>
 
<script>
import axios from 'axios';
import setting from './setting.js';
import Input from './modal/input.vue';

export default { 
  name: 'book_detail',
  components: {
      Input
  },
  data () {
    return {
      id: 0,
      categories:'',
      classificationcodes:'',
      admin_status:'admin'
    }
  },
  computed: {
    book() { return this.$store.getters['books/book'] },
  },
  mounted () {
    this.setBook();
    this.categories = setting.func1();
    this.classificationcodes = setting.func2();
    axios.get('/api/users/1')
      .then(response => (
      this.admin_status = response.data.admin
    ))
  },
  methods: {
    setBook: function () {
      this.$store.dispatch('books/fetchBook', this.id)
    },
  },
  created() {
    this.id = this.$route.params.id
  },
  // $routeが変更されたときにidを再設定する
  watch: {
    '$route'(to, from) {
      this.id = to.params.id
    }
  }
}
</script>

 
<style scoped>
.container{
 width:90%;
}
.main-box{
  width:90%;
  margin:auto;
  box-sizing: content-box;
  width: 80%;
  height:400px;
  border: solid #5B6DCD 10px;
  padding: 5px;
  background: yellow;
}
.sub-box{
  background: white;
  width:70%;
  margin:auto; 
  display:flex;
}
.element1{
  width:300px;
  border: 1px;
}
.element2{
  width:500px;
  padding:5px;
  border: dashed 2px #5b8bd0;/*点線*/
}
.element2 p{
  font-size:20px;
}
.photo_box {
  margin:2px 0.5px 0.5px 0.5px; 
  padding:0px; 
  height: 10px;
}
.photo_just {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 250px;
  height: auto;
}
.title_back {
  padding: 4px;
  color: #fff;
  background: #015dac;
  background-image: radial-gradient(#0175d5 13%, transparent 13%), radial-gradient(#0175d5 13%, transparent 13%);
  background-size: 50px 50px;
  background-position: 0 0, 25px 25px;
}
.site_link{
  width:110px;
  margin:0 5px 10px 0;
}
.classificationcode_wide{
  width:55px;
}
</style>