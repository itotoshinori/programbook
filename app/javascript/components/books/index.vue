<template>
    <div id="app">
        <div class="container">
            <div>
                <span v-if="admin_status==true"><b-button pill v-b-modal.input-modal variant="primary" style="margin-bottom:10px;">新規</b-button></span>
                <b-modal id="input-modal" title="新規登録" hide-footer>
                    <div class="form">
                        <div class="form-group">
                            <label class="label-left-margin">タイトル</label>
                            <input v-model="post.title" placeholder="タイトル" class="form-control">
                            <span v-if="error.title">
                                <div style="color:red;">{{ error.title }}</div>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">出版社</label>
                            <input v-model="post.publisher" placeholder="出版社" class="form-control">
                            <span v-if="error.publisher">
                                <div style="color:red;">{{ error.publisher }}</div>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">作者（代表）</label>
                            <input v-model="post.author" placeholder="作者（代表）" class="form-control">
                            <span v-if="error.author">
                                <div style="color:red;">{{ error.author }}</div>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">発刊日</label>
                            <input type="date" v-model="post.publication_date" placeholder="発刊日" class="form-control">
                            <span v-if="error.publication_date">
                                <div style="color:red;">{{ error.publication_date }}</div>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">説明</label>
                            <textarea v-model="post.description" placeholder="説明" class="form-control"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">画像URL</label>
                            <input v-model="post.photo" placeholder="画像URL" class="form-control">
                            <span v-if="error.description">
                                <div style="color:red;">{{ error.photo }}</div>
                            </span>
                        </div>
                        <div class="form-group">
                            <input type="radio" id="1" value="1" v-model="post.classificationcode">
                            <label class="label-left-margin">本</label>
                            <input type="radio" id="2" value="2" v-model="post.classificationcode">
                            <label class="label-left-margin">サイト</label>
                            <input type="radio" id="3" value="3" v-model="post.classificationcode">
                            <label class="label-left-margin">動画</label>
                            <input type="radio" id="4" value="4" v-model="post.classificationcode">
                            <label class="label-left-margin">その他</label>
                        </div>
                        <span v-if="error.classificationcode">
                            <div style="color:red;">{{ error.classificationcode }}</div>
                        </span>
                        <div class="form-group">
                            <select v-model="post.category_code1">
                                <option disabled value="">カテゴリーを選択</option>
                                <option v-for="category in categories" v-bind:value="category.id"
                                    v-bind:key="category.id">
                                    {{ category.name }}
                                </option>
                            </select>
                            <span v-if="error.category_code1">
                                <div style="color:red;">{{ error.category_code1 }}</div>
                            </span>
                            <select v-model="post.category_code2">
                                <option disabled value="">カテゴリーを選択2</option>
                                <option v-for="category in categories" v-bind:value="category.id"
                                    v-bind:key="category.id">
                                    {{ category.name }}
                                </option>
                            </select>
                            <select v-model="post.category_code3">
                                <option disabled value="">カテゴリーを選択3</option>
                                <option v-for="category in categories" v-bind:value="category.id"
                                    v-bind:key="category.id">
                                    {{ category.name }}
                                </option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">公式サイト</label>
                            <input v-model="post.official_site" placeholder="公式サイト" class="form-control">
                            <span v-if="error.official_site">
                                <div style="color:red;">{{ error.official_site }}</div>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">アマゾンURL</label>
                            <input v-model="post.amazon" placeholder="アマゾンURL" class="form-control">
                        </div>
                        <div class="form-group">
                            <label class="label-left-margin">楽天URL</label>
                            <input v-model="post.rakuten" placeholder="楽天URL" class="form-control">
                        </div>
                        </span>
                    </div>
                    <p class="modal_checkbox"><input v-model="post.introductory" type="checkbox" name="checkbox"  />
                    入門書 </p>
                    <div class="form-group">
                        <label class="label-left-margin">評価点</label>
                        <input  v-model="post.evaluation" placeholder="評価点" class="form-control">
                    </div>
                    <div class="form-group">
                        <label class="label-left-margin">検索件数（１年縛り　本はブログ+本名+作者+作者 本以外はブログを付けない）
                        <span v-if="post.classificationcode == 1">ブログ</span>　{{post.title}}　{{post.publisher}}　{{post.author}}</label>
                        <input v-model="post.search_point" placeholder="検索件数" class="form-control">
                    </div>
                    <p class="text-center"><button @click="addBook" class="btn btn-primary">追加</button></p>
                </b-modal>
            </div>
            <!--<Home />-->
            <Books />
            <!-- router-viewにコンポーネントが描画される -->
            <router-view />
        </div>
    </div>
</template>

<script>
    import axios from 'axios';
    import setting from './setting.js';
    import Home from '../home';
    import Books from './categories/booksCategory.vue';

    export default {
        components: {
            Books,
            Home
        },
        data: function () {
            return {
                post: {
                    title: "",
                    description: "",
                    photo: '',
                    publisher: '',
                    author: '',
                    classificationcode: '',
                    category_code1: '',
                    category_code2: '',
                    category_code3: '',
                    official_site: '',
                    amazon: '',
                    rakuten: '',
                    publication_date: '',
                    introductory:false,
                    search_point:'',
                    evaluation:'',
                },
                error: {
                    title: "",
                    photo: '',
                    publisher: '',
                    author: '',
                    classificationcode: '',
                    category_code1: '',
                    official_site: '',
                    amazon: '',
                    publication_date: ''
                },
                category: '',
                categories: '',
                admin_status:''
            }
        },
        computed: {
            books() {
                return this.$store.getters['books/books']
            }
        },
        mounted() {
            this.categories = setting.func1();
            this.classificationcode = setting.func2();
            axios.get('/api/users/1')
                .then(response => (
                this.admin_status = response.data.admin
            ))
        },
        methods: {
            addBook: function () {
                if (this.post.title != '' &&
                    this.post.photo != '' &&
                    this.post.publisher != '' &&
                    this.post.classificationcode != '' &&
                    this.post.category_code1 != '' &&
                    this.post.official_site != '' &&
                    this.post.publication_date != '') {
                    if(this.$store.dispatch('books/createBook', this.post)){
                        this.post = {}
                        this.error = {}
                        this.$store.dispatch('books/fetchBooks')
                        this.$store.dispatch('books/fetchBooks')
                        this.closeModal()
                    }else{
                        alert('データの登録に失敗しました。文字の長さ等のご確認をお願いします')
                    }  
                } else {
                    if (this.post.title == '') {
                        this.error.title = "入力して下さい"
                    }
                    if (this.post.photo == '') {
                        this.error.photo = "入力して下さい"
                    }
                    if (this.post.author == '') {
                        this.error.author = "入力して下さい"
                    }
                    if (this.post.publisher == '') {
                        this.error.publisher = "入力して下さい"
                    }
                    if (this.post.official_site == '') {
                        this.error.official_site = "入力して下さい"
                    }
                    if (this.post.classificationcode == '') {
                        this.error.classificationcode = "入力して下さい"
                    }
                    if (this.post.category_code1 == '') {
                        this.error.category_code1 = "入力して下さい"
                    }
                    if (this.post.publication_date == '') {
                        this.error.publication_date = "入力して下さい"
                    }
                }
            },
            openModal: function () {
                // 開く
                this.$bvModal.show('input-modal')
            },
            closeModal: function () {
                // 閉じる
                this.$bvModal.hide('input-modal')
            }
        }
    }
</script>

<style lang="scss" scoped>
    img {
        width: 100%;
        height: 400px;
        object-fit: cover;
        margin-bottom: 10px;
    }

    .container {
        width: 90%;
    }

    .form {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin-top: 20px;

        &-control {
            width: 450px;
            min-height: 24px;
            font-size: 1rem;
            border: 1px solid #ced4da;
            padding: 5px;
        }
    }

    button {
        width: 200px;
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

    .main-title {
        margin-top: 2px;
        margin-bottom: -30px;
        margin-left: 10px;
        font-size: 30px;
        font-weight: bold;
    }

    .menu {
        padding: 12px;
        color: #5a5c5f;
    }

    .menu-card {
        width: 16.5%;
        margin-top: 35px;
    }

    .menu-card-inner {
        padding: 2px 10px 2px 10px;
        background-color: #f7f7f7;
        border-radius: 7px;
        box-shadow: 1px 1px 4px #d2d4d6;
        text-align: center;
        margin: 0 4px;
        height: 450px;
    }

    .menu-title {
        margin-bottom: 8px;
        font-size: 15px;
        text-align: left;
    }

    .menu-text {
        font-size: 15px;
        text-align: left;
    }

    .menu-card-wrapper {
        display: flex;
        flex-wrap: wrap;
    }

    .photo_box {
        margin: 2px 0.5px 0.5px 0.5px;
        padding: 0px;
        height: 250px;
    }

    .photo_just {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 160px;
        height: auto;
    }

    .display-none {
        display: none;
    }

    .label-left-margin {
        margin-left: 5px;
    }

    .modal_checkbox{
        margin-left: 20px;
    }
</style>