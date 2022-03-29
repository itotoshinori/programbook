<template>
  <div id="app">
    <div class="container">
      <h2>{{book.title}}</h2>
      <figure>
        <span v-if="book.photo">
            <img :src="book.photo" class="photo_just"/>
        </span>
      </figure>
      <h5>著　者：{{book.author}}</h5>
      <h5>出版社：{{book.publisher}}</h5>
      <h5 v-if="book.publication_date">発刊日：{{book.publication_date}}</h5>
      <h5>調査点：{{ book.total_point }}点(カテゴリー{{ book.category_rank }}位)</h5>
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
      <a href="#" onClick="window.close();">ウィンドウを閉じる</a><br/>
      <span v-if="admin_status==true">
        <p><Input /></p>
      </span>
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
.container{
 width:60%;
}
.content {
	margin-bottom: 15px;
	line-height: 1.6em;
}
figure {
	float: left;
	margin: 0 15px 15px 0;
	width: 30%;
}
.photo_just {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 300px;
  height: auto;
}
figure img {
	max-width: 100%;
}
.site_link{
  width:110px;
  margin:0 10px 5px 0;
}
.classificationcode_wide{
  width:55px;
}
</style>