<template>
  <div id="app">
    <!-- router-viewにコンポーネントが描画される -->
    <router-view/>
    <Counter/>
    <div class="form">
      <div class="form-group">
        <input v-model="title" placeholder="title" class="form-control">
      </div>
      <div class="form-group">
        <input v-model="description" placeholder="description" class="form-control">
      </div>
      <button @click="addBook">メモを追加</button>
    </div>
    <div class="flex">
      <div v-for="book in books" :key="book.id" class="card">
        <div class="card-body">
          <div class="card-title">
            {{ book.title }}
            <div>
              <router-link :to="`article/${book.id}`">詳細</router-link>
            </div>
            <router-view/>
          </div>
          {{ book.description }}
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
      books: "books",
      title: '',
      description: '',
    }
  },
  mounted () {
    this.setBook();
  },
  methods: {
    setBook: function () {
      axios.get('/api/books')
      .then(response => (
        this.books = response.data
      ))
    },
    addBook: function() {
      axios.post('/api/books', {
        title: this.title,
        description: this.description
      })
      .then(response => (
        this.setBook()
      ));
    }
  }
}
</script>

<style lang="scss" scoped>
.form {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin: 32px;
  &-group {
    margin-bottom: 1rem;
  }
  &-control {
    width: 600px;
    min-height: 24px;
    font-size: 1rem;
    border: 1px solid #ced4da;
    padding: 4px 8px;
  }
}

button {
  width: 200px;
}

.flex {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.card {
  width: 238px;
  border: 1px solid rgba(0,0,0,.125);
  border-radius: .25rem;
  margin: 16px;
  &-body {
    padding: 1.25rem;
  }
  &-title {
    margin-bottom: .75rem;
    font-weight: 600;
  }
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
</style>