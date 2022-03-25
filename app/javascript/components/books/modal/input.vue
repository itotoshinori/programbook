<template>
    <div id="app">
        <div class="container">
            <b-button pill v-b-modal.input-modal variant="primary">編集</b-button>
            <b-modal id="input-modal" title="編集" hide-footer>
                <div class="form-group">
                    <div class="form-group">
                        <label class="label-left-margin">タイトル</label>
                        <input v-model="book.title" placeholder="タイトル" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="label-left-margin">出版社</label>
                    <input v-model="book.publisher" placeholder="出版社" class="form-control">
                </div>
                <div class="form-group">
                    <label class="label-left-margin">作者（代表）</label>
                    <input v-model="book.author" placeholder="作者（代表）" class="form-control">
                </div>
                <div class="form-group">
                    <label class="label-left-margin">発刊日</label>
                    <input type="date" v-model="book.publication_date" placeholder="発刊日" class="form-control">
                </div>
                <div class="form-group">
                    <label class="label-left-margin">説明</label>
                    <textarea v-model="book.description" placeholder="説明" class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label class="label-left-margin">画像URL</label>
                    <input v-model="book.photo" placeholder="画像URL" class="form-control">
                </div>
                <div class="form-group">
                    <input type="radio" id="1" value="1" v-model="book.classificationcode">
                    <label class="label-left-margin">本</label>
                    <input type="radio" id="2" value="2" v-model="book.classificationcode">
                    <label class="label-left-margin">サイト</label>
                    <input type="radio" id="3" value="3" v-model="book.classificationcode">
                    <label class="label-left-margin">動画</label>
                    <input type="radio" id="4" value="4" v-model="book.classificationcode">
                    <label class="label-left-margin">その他</label>
                </div>
                <div class="form-group">
                    <select v-model="book.category_code1">
                        <option disabled value="" selected>カテゴリーを選択</option>
                        <option v-for="category in categories" v-bind:value="category.id" v-bind:key="category.id">
                            {{ category.name }}
                        </option>
                    </select>
                    <select v-model="book.category_code2">
                        <option disabled value="" selected>カテゴリーを選択2</option>
                        <option v-for="category in categories" v-bind:value="category.id" v-bind:key="category.id">
                            {{ category.name }}
                        </option>
                    </select>
                    <select v-model="book.category_code3">
                        <option disabled value="" selected>カテゴリーを選択3</option>
                        <option v-for="category in categories" v-bind:value="category.id" v-bind:key="category.id">
                            {{ category.name }}
                        </option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="label-left-margin">公式サイト</label>
                    <input v-model="book.official_site" placeholder="公式サイト" class="form-control">
                </div>
                <div class="form-group">
                    <label class="label-left-margin">アマゾンURL</label>
                    <input v-model="book.amazon" placeholder="アマゾンURL" class="form-control">
                </div>
                <div class="form-group">
                    <label class="label-left-margin">楽天URL</label>
                    <input v-model="book.rakuten" placeholder="楽天URL" class="form-control">
                </div>
                </span>
                <p class="modal_checkbox"><input v-model="book.introductory" type="checkbox" name="checkbox"  />
                    入門書 </p> 
                <div class="form-group">
                    <label class="label-left-margin">評価点</label>
                    <input  v-model="book.evaluation" placeholder="評価点" class="form-control">
                </div>
                <div class="form-group">
                    <label class="label-left-margin">検索件数</label>
                    <span v-if="book.classificationcode == 1">ブログ</span>　{{book.title}}　{{book.publisher}}　{{book.author}}</label>
                    <input  v-model="book.search_point" placeholder="検索件数" class="form-control">
                </div>
                <div class="button_wrapper" style="text-align:center;">
                    <button @click="updateBook" class="btn btn-primary">修正</button>
                </div>    
            </b-modal>
        </diV>
    </div>
</template>

<script>
    import axios from 'axios';
    import setting from '../setting.js';

    export default {
        name: 'book_detail',
        data() {
            return {
                id: 0,
                post: {
                    id:'',
                    title:'',
                    description: '',
                    photo:'',
                    publisher:'',
                    author:'',
                    classificationcode:'',
                    category_code1:'',
                    category_code2:'',
                    category_code3:'',
                    official_site:'',
                    amazon:'',
                    rakuten:'',
                    publication_date:'',
                    introductory:false,
                    search_point:'',
                    evaluation:'',
                },
                category: '',
                categories: '',
            }
        },
        computed: {
            book() {
                return this.$store.getters['books/book']
            },
        },
        mounted() {
            this.setBook();
            this.categories = setting.func1();
            this.classificationcode = setting.func2();
        },
        methods: {
            setBook: function () {
                this.$store.dispatch('books/fetchBook', this.id)
            },
            updateBook: function(){
                this.post.id = this.book.id
                this.post = this.book
                if(this.$store.dispatch('books/updateBook',this.post)){
                    this.closeModal()
                }else{
                    alert('データの更新に失敗しました。文字の長さなどを確認願います')
                }
            },
            openModal: function() {
                // 開く
                this.$bvModal.show('input-modal')
            },
            closeModal: function() {
                // 閉じる
                this.$bvModal.hide('input-modal')
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
        },
    }
</script>


<style scoped>
    .container {
        width: 65%;
    }

    .photo_box {
        margin: 2px 0.5px 0.5px 0.5px;
        padding: 0px;
        height: 10px;
    }

    .wrapper {
        display: flex;
    }

    .element1 {
        width: 300px;
        border: 1px;
    }

    .element2 {
        width: 500px;
        padding: 10px;
        border: dashed 2px #5b8bd0;
        /*点線*/
    }

    .element2 p {
        font-size: 20px;
    }

    .photo_just {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 280px;
        height: auto;
    }

    .title_back {
        padding: 4px;
        color: #fff;
        background: #015dac;
        background-image: radial-gradient(#0175d5 13%, transparent 13%), radial-gradient(#0175d5 13%, transparent 13%);
        background-size: 50px 50px;
        background-position: 0 0, 25px 25px;
    }

    .site_link {
        width: 120px;
    }

    .modal_checkbox{
        margin-left: 5px;
    }
</style>