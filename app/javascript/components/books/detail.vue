<template>
  <div id="app">
    <div class="container">
      <h2>{{book.title}}</h2>
      <figure>
        <span v-if="book.photo">
            <img :src="book.photo" />
        </span>
      </figure>
      <h5>著　者：{{book.author}}</h5>
      <h5>出版社：{{book.publisher}}</h5>
      <h5 v-if="book.publication_date">発刊日：{{book.publication_date}}</h5>
      <p>
        <span v-if="book.introductory" class="badge badge-info">入門書</span>
        <span v-if="book.classificationcode" class="badge badge-pill badge-secondary classificationcode_wide">
          {{classificationcodes[book.classificationcode].name}}
        </span>
        <span v-if="book.category_code1" class="badge badge-warning">
          {{categories[book.category_code1-1].name}}
        </span>
        <span v-if="book.category_code2" class="badge badge-info">
          {{categories[book.category_code2-1].name}}
        </span>
        <span v-if="book.category_code3" class="badge badge-dark">
          {{categories[book.category_code3-1].name}}
        </span>
      </p>
      <P>
        <span v-if="book.official_site">
          <a :href="book.official_site" target="_blank" class="btn btn-primary site_link">公式サイト</a>
        </span>
        <span v-if="book.amazon">
          <a :href="book.amazon" target="_blank" class="btn btn-warning site_link">Amazon</a>
        </span>
        <span v-if="book.rakuten">
          <a :href="book.rakuten" target="_blank" class="btn btn-danger site_link">楽天</a>
        </span>
      </p>
      <p><a href="#" class="btn btn-success" onclick="history.back(-1);return false;">前のページに戻る</a></p>
      <span v-if="admin_status==true"><p><Input /></p></span>
    </div>
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
p {
	margin-bottom: 15px;
	line-height: 1.6em;
  overflow: hidden;
}
.float_none {
	clear: both;
}
figure {
	float: left;
	margin: 0 15px 15px 0;
	width: 30%;
}
figure img {
	max-width: 100%;
}
.container{
 width:60%;
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
.photo_box{
  margin:auto;
  width:70%;
  background:white;
  height:400px;
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
  width:150px;
  margin:0 10px 10px 0;
}
.classificationcode_wide{
  width:55px;
}
</style>