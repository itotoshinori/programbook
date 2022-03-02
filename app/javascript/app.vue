<template>
  <div id="app">
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark mb-3 sticky-top">
     <a class="navbar-brand" href="#">miyacleApp</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav4" aria-controls="navbarNav4" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav4">
          <ul class="navbar-nav">
              <li class="nav-item active">
                  <router-link to="/" class="nav-link">Home</router-link>
              </li>
              <li class="nav-item">
                  <router-link to="/books/index" class="nav-link">Books</router-link>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="#">サイトについて</a>
              </li>
         </ul>
      </div>
    </nav>
    <!-- router-viewにコンポーネントが描画される -->
    <router-view/> 
    <p><Counter/></p>
    <p><DoubleCounter/></p>
  </div>
 </template>

<script>
  import Counter from './components/Counter.vue';
  import DoubleCounter from './components/DoubleCounter'
  import axios from 'axios';
  import BootstrapVue from 'bootstrap-vue';

export default {
  components: {
    Counter,
    DoubleCounter
  },
}
</script>
<style>
<style scoped>
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
