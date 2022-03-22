<template>
  <div id="app">
    <div class="container">
      <div class="wrapper">
        <div class="element1">
          <span v-if="book.photo">
            <img :src="book.photo" class="photo_just"/>
          </span>
        </div>
        <div class="element2">
          <p class="title_back">
            {{book.title}}
          </p>
          <p>著　者：{{book.author}}</p>
          <p>出版社：{{book.publisher}}</p>
          <p v-if="book.publication_date">発刊日：{{book.publication_date}}</p>
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
        </div>
      </div>
      <br>
      <p style="text-align:center;"><a href="#" class="btn btn-success" onclick="history.back(-1);return false;">前のページに戻る</a></p>
      <span v-if="admin_status"><p style="text-align:center;"><Input /></p></span>
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
    axios.get('/api/user/index')
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
 width:65%;
}
.photo_box {
  margin:2px 0.5px 0.5px 0.5px; 
  padding:0px; 
  height: 10px;
}
.wrapper {
   display:flex;
}
.element1{
  width:300px;
  border: 1px;
}
.element2{
  width:500px;
  padding:10px;
  border: dashed 2px #5b8bd0;/*点線*/
}
.element2 p{
  font-size:20px;
}
.photo_just {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 280px;
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