import axios from 'axios'

const state = {
 books:"books",
 createBooks:'',
}

const getters = {
  books: state => state.books
}

const actions = {
  async fetchBooks({ commit }) {
    await axios.get('/api/books')
        .then(response => (
        commit('setBooks', response.data)
    ))
  },
  createBook({ commit }, post) {
    const response = axios.post('/api/books', {
      title: post.title,
      description: post.description,
      photo:post.photo
    })
    commit('createBook', response.data);
  }
}

const mutations = {
  setBooks: (state, books) => (state.books = books),
  createBook: function(state,data){
    state.book = data
  }
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations
}