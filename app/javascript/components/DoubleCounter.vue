<template>
  <div>
    <button @click="increment" class="btn btn-primary"  >increment {{ step }}</button>
    <span>total {{ count }}</span>
  </div>
</template>

<script>
  export default {
    name: "DoubleCounter",
    computed: {
      step() { return this.$store.getters['doubleCounter/step']},
      count() { return this.$store.getters['doubleCounter/count']}
    },
    methods: {
      increment() {
        this.$store.dispatch('doubleCounter/increment')
      }
    }
  }
</script>

<style scoped>

</style>