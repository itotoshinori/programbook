<template>
  <div id="app">
    <div class="container">
      <!-- router-viewにコンポーネントが描画される -->
      <router-view/>
      <button type="button" class="btn btn-warning">Warning</button>
      <div class="form">
        <div class="form-group">
          <input v-model="post.title" placeholder="タイトル" class="form-control">
          <span v-if="error.title">
            <div style="color:red;">{{ error.title }}</div>
          </span>
        </div>
        <div class="form-group">
          <input v-model="post.description" placeholder="説明" class="form-control">
        <span v-if="error.description">
            <div style="color:red;">{{ error.description }}</div>
        </span>
        </div>
        <div class="form-group">
          <input v-model="post.photo" placeholder="画像URL" class="form-control">
          <span v-if="error.description">
            <div style="color:red;">{{ error.photo }}</div>
        </span>
        </div>
        <button @click="addBook" class="btn btn-primary">追加</button>
      </div>
      <div class="main-title">Ruby</div>
        <div class="menu-card-wrapper">
          <div v-for="book in books" :key="book.id" class="menu-card">
            <div class="menu-card-inner">
              <p class="photo_box">
              <span v-if="book.photo">
                <img :src="book.photo" class="photo_just"/>
              </span>
              </p>
              <h3 class="menu-title"><router-link :to="`detail/${book.id}`">{{ book.title }}</router-link></h3>
              <p class="menu-text">{{ book.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data: function () {
    return {
      post: {
        title:"",
        description: "",
        photo:'',
      },
      error:{
        title:"",
        description: "",
        photo:'',
      }
    }
  },
  computed: {
    books() { return this.$store.getters['books/books']}
  },
  mounted () {
    this.setBook();
  },
  methods: {
    setBook: function () {
      //２回呼び出さないと更新されない
      this.$store.dispatch('books/fetchBooks')
      this.$store.dispatch('books/fetchBooks')
      axios.get('/api/users')
      .then(response => (
        this.id = response.data.user_admin
      ))
    },
    addBook: function() {
      console.log(this.post)
      if(this.post.title != '' && this.post.description != '' && this.post.photo != ''){
        this.$store.dispatch('books/createBook',this.post)
        this.error = {}
        this.post.title = ""
        this.post.description = ""
        this.post.photo = ""
        this.$store.dispatch('books/fetchBooks')
        this.$store.dispatch('books/fetchBooks')
      } else {
        if(this.post.title == ''){this.error.title = "タイトルを入力して下さい"}
        if(this.post.description == ''){this.error.description = "説明を入力して下さい"}
        if(this.post.photo == ''){this.error.photo = "画像のURLを入力して下さい"}
      }
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
.container{
 width:90%;
}
.form {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
  &-control {
    width: 700px;
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
</style>