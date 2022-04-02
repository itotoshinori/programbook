import axios from 'axios'

const state = {
 books:"books",
 book:'',
 createBooks:'',
 mode:16
}

const getters = {
  books: state => state.books,
  book: state => state.book,
  mode:state => state.mode
}

const actions = {
  async fetchBooks({ commit }) {
    let url = '/api/books'
    await axios.get(url)
        .then(response => (
        commit('setBooks', response.data)
    ))
  },
  async fetchBook({ commit },id) {
      await axios.get('/api/books/'+id)
          .then(response => (
          commit('setBook', response.data)
    ))
  },
  async createBook({ commit }, post) {
    const response = await axios.post('/api/books', {
      title: post.title,
      description: post.description,
      photo:post.photo,
      publisher:post.publisher,
      author:post.author,
      classificationcode:post.classificationcode,
      category_code1:post.category_code1,
      category_code2:post.category_code2,
      category_code3:post.category_code3,
      publisher:post.publisher,
      author:post.author,
      official_site:post.official_site,
      amazon:post.amazon,
      rakuten:post.rakuten,
      googlebooks:post.googlebooks,
      publication_date:post.publication_date,
      introductory:post.introductory,
      search_point:post.search_point,
      evaluation:post.evaluation,
      user_id:post.user_id
    })
    .then(response => (
        commit('createBook', response.data)
    ))
      .catch((e) => {
        console.log(e)
    })  
  },
  async updateBook({ commit }, post) {
    const response = await axios.put('/api/books/' + post.id, {
      title: post.title,
      description: post.description,
      photo:post.photo,
      publisher:post.publisher,
      author:post.author,
      classificationcode:post.classificationcode,
      category_code1:post.category_code1,
      category_code2:post.category_code2,
      category_code3:post.category_code3,
      publisher:post.publisher,
      author:post.author,
      official_site:post.official_site,
      amazon:post.amazon,
      rakuten:post.rakuten,
      googlebooks:post.googlebooks,
      publication_date:post.publication_date,
      introductory:post.introductory,
      search_point:post.search_point,
      evaluation:post.evaluation,
      user_id:post.user_id
    })
  },
  deleteBook({ commit }, id){
    axios.delete('/api/books/'+ id)
          .then(response => (
          commit('deleteBook', response.data)
    ))
  },
  changeMode({ commit },mode) {
    commit('changeMode',mode)
  }
}

const mutations = {
  setBooks: (state, books) => (state.books = books),
  setBook: (state, book) => (state.book = book),
  createBook: function(state,data){
    state.book = data
  },
  deleteBook: function(state,data){
    state.book = data
  },
  changeMode: function(state,mode) {
    if(mode==1){
      state.mode = 16
    }else{
      state.mode = 1000
    }
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}