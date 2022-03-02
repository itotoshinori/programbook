<template>
  
  <div id="app">
    <p>記事No：{{ id }}</p>
  
  <p><a href="#" class="btn btn-success" onclick="history.back(-1);return false;">戻る</a></p>
  </div>
  
</template>
 
<script>
export default { 
  name: 'book_detail',   
  data () {
    return {
      id: 0
    }
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
</style>