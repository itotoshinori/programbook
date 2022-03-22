<template>
  <div id="app">
    <!-- router-viewにコンポーネントが描画される -->
      <router-view/>
    <div class="main-title">{{category}}</div>
    <div class="menu-card-wrapper">
      <div v-for="book in books" :key="book.id" class="menu-card">
        <span class="menu-card-inner">
          <p class="photo_box">
            <span v-if="book.photo">
              <img :src="book.photo" class="photo_just"/>
            </span>
          </p>
          <h3 class="menu-title"><router-link :to="`detail/${book.id}`">{{ book.title }}</router-link></h3>
          <p class="menu-text">
            {{ book.publisher }}<br />
            {{ book.author }} 著<br />
            <span style="color:red">{{book.publication_date}} 刊</span><br />
            <span v-if="book.classificationcode" class="badge badge-pill badge-danger">
              {{classificationcode[book.classificationcode].name}}
            </span>
            <span v-if="book.category_code1" class="badge badge-success">
                {{categories[book.category_code1].name}}
            </span>
            <span v-if="book.category_code2" class="badge badge-info">
            {{categories[book.category_code2].name}}
            </span>
            <span v-if="book.category_code3" class="badge badge-dark">
                {{categories[book.category_code3].name}}
            </span>
          </p>
        </span>
        <span style="display:none">{{ category_num = book.category_code1}}</span>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import setting from '../setting.js';

export default {
  data: function () {
    return {
      post: {
        title:"",
        description: "",
        photo:'',
        publisher:'',
        author:'',
        classificationcode:'',
        category_code1:'',
        category_code2:'',
        category_code3:'',
        official_site:'',
        amazon:'',
        rakuten:'',
        publication_date:''
      },
      error:{
        title:"",
        photo:'',
        publisher:'',
        author:'',
        classificationcode:'',
        category_code1:'',
        official_site:'',
        amazon:'',
        publication_date:''
      },
      category:'',
      categories:'',
      category_num:''
    }
  },
  computed: {
    books() { return this.$store.getters['books/books'] }
  },
  mounted () {
    this.setBooks();
    this.categories = setting.func1();
    this.classificationcode = setting.func2();
  },
  methods: {
    setBooks: function () {
      const category_id = this.category     
      this.$store.dispatch('books/fetchBooks')
      //this.$store.dispatch('books/fetchBooks',category_id)
      axios.get('/api/users/1')
      .then(response => (
        this.admin_status = response.data.admin
      ))
    },
    addBook: function() {
      console.log(this.post)
      if(this.post.title != '' && 
       this.post.photo != '' && 
       this.post.publisher != '' &&
       this.post.classificationcode != '' &&
       this.post.category_code1 != '' && 
       this.post.official_site != '' &&   
       this.post.publication_date != ''){
        this.$store.dispatch('books/createBook',this.post)
        this.error = {}
        this.post.title = ""
        this.post.description = ""
        this.post.photo = ""
        this.$store.dispatch('books/fetchBooks')
        this.$store.dispatch('books/fetchBooks')
        this.closeModal()
      } else {
        if(this.post.title == ''){this.error.title = "入力して下さい"}
        if(this.post.photo == ''){this.error.photo = "入力して下さい"}
        if(this.post.publisher == ''){this.error.publisher = "入力して下さい"}
        if(this.post.official_site == ''){this.error.official_site = "入力して下さい"}
        if(this.post.classificationcode == ''){this.error.classificationcode = "入力して下さい"}
        if(this.post.category_code1 == ''){this.error.category_code1 = "入力して下さい"}
        if(this.post.publication_date == ''){this.error.publication_date = "入力して下さい"}
      }
    },
    openModal: function() {
      // 開く
      this.$bvModal.show('input-modal')
    },
    closeModal: function() {
      // 閉じる
      this.$bvModal.hide('input-modal')
    }
  }
}
</script>

<style lang="scss" scoped>
img {
  width: 100%;
  height: 400px;
  object-fit: cover;
  margin-bottom:10px;
}
.form {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
  &-control {
    width: 450px;
    min-height: 24px;
    font-size: 1rem;
    border: 1px solid #ced4da;
    padding: 5px;
  }
}

button {
  width: 200px;
}

a {
  color: blue;
  text-decoration: none;
}
 
/* リンクがアクティブになっているときに適用 */
a.router-link-exact-active {
  color: black;
  font-weight: bold;
}

.main-title{
  margin-top:2px;
  margin-bottom:-30px;
  margin-left:10px;
  font-size:30px;
  font-weight: bold;
}
.menu {
  padding: 12px;
  color: #5a5c5f;
}
.menu-card {
  width: 16.5%;
  margin-top: 35px;
}
.menu-card2 {
  width: 100%;
  border:1px;
}
.menu-card-inner {
  padding: 2px 10px 2px 10px;
  background-color: #f7f7f7;
  border-radius: 7px;
  box-shadow: 1px 1px 4px #d2d4d6;
  text-align: center;
  margin: 0 4px;
  height:450px;
}
.menu-title {
  margin-bottom: 8px;
  font-size:15px;
  text-align:left;
}
.menu-text {
  font-size: 15px;
  text-align:left;
}
.menu-card-wrapper {
  display: flex;
  flex-wrap: wrap;
}
.photo_box {
  margin:2px 0.5px 0.5px 0.5px; 
  padding:0px; 
  height: 250px;
}
.photo_just {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 160px;
  height: auto;
}
.display-none{
  display:none;
}
.label-left-margin{
  margin-left:5px;
}
</style>