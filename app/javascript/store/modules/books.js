import axios from 'axios'

const state = {
 books:"books",
 book:'',
 createBooks:'',
}

const getters = {
  books: state => state.books,
  book: state => state.book,
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
  createBook({ commit }, post) {
    const response = axios.post('/api/books', {
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
    })
    commit('createBook', response.data);
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
    })
  },
  deleteBook({ commit }, id){
    axios.delete('/api/books/'+id)
          .then(response => (
          commit('deleteBook', response.data)
    ))
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
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}