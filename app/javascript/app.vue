<template>
  <div id="app">
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark mb-3 sticky-top">
     <a class="navbar-brand" href="/">プログラミングお勧め教材</a>
     <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav4" aria-controls="navbarNav4" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav4">
          <ul class="navbar-nav">
              <li class="nav-item active">
                  <router-link to="/" class="nav-link">Home</router-link>
              </li>
              <li v-if="admin_status==false">
                  <a href="/users/sign_in" class="nav-link">ログイン{{admin_status}}</a>
              </li>
              <li v-if="admin_status">
                  <a href="/sigin/sigin_out" class="nav-link">サインアウト{{admin_status}}</a>
              </li>
              <li class="nav-item">
                  <a class="nav-link" href="#">サイトについて</a>
              </li>
         </ul>
      </div>
    </nav>
    <!--
    <p><Counter/></p>
    <p><DoubleCounter/></p>
    -->
    <router-view/>
   
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
    DoubleCounter,
  },
  data: function () {
    return {
      admin_status:'admin'            
    }
  },
  mounted() {
    axios.get('/api/users/1')
      .then(response => (
        this.admin_status = response.data.admin
    ))
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

.container{
 width:90%;
}
</style>
