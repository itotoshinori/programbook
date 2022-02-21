<template>
  <div id="app">
    <div>
      <router-link to="/" tag="button" class="btn btn-primary">Home</router-link>
      <router-link to="/books" tag="button" class="btn btn-secondary">Books</router-link>
      <router-link to="/article/5">記事 NO.5</router-link>
      <router-link to="/article/33">記事 NO.33</router-link>
    </div>
    <!-- router-viewにコンポーネントが描画される -->
    <router-view/>
  </div>
</template>

<script>
  import Counter from './components/Counter.vue';
  import axios from 'axios';
  import BootstrapVue from 'bootstrap-vue';

export default {
  components: {
    Counter
  },
}
</script>

