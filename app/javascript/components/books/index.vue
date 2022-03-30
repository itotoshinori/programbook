<template>
    <div id="app">
        <div class="container">
            <p>
                <button @click="displayLegend()" class="btn btn-primary">{{layLegendTittle}}</button>
                <ul :class="legend">
                    <div class="legendBox">
                        <li>お勧めソフトウェア関連の教材を言語別に紹介します</li>
                        <li>教材は、書籍・サイト・動画などの媒体のものを紹介しております</li>
                        <li>発刊から２年度以下のものに絞っております</li>
                        <li>ランキングは独自の調査で点数付けしてつけてます</li>
                        <li>ご意見や改善要望があればメールフォームよりお願いします</li>
                    </div>
                </ul>  
            </P>
            <span v-if="admin_status==true">
                <p>
                    <input v-model="query" placeholder="グーグルブックスワード検索" class="input-primary search_input" />
                    <button @click="getResult()" class="btn btn-primary btn-sm add_button">検索</button>
                </p>
                <div v-for="(item,index) in items">
                    <p>
                        <button @click="serach_click(index)" class="btn btn-primary">追加</button>
                        {{ item.volumeInfo.title }}
                        作　者：{{item.volumeInfo.authors[0]}}
                        出版社：{{ item.volumeInfo.publisher }}
                    </p>
                </div>
            </span>
            <div>
                <span v-if="admin_status==true">
                    <b-button pill v-b-modal.input-modal variant="primary" style="margin-bottom:10px;">新規</b-button>
                </span>
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
                            <span v-if="error.photo">
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
                        <div class="form-group">
                            <label class="label-left-margin">GoogleBooks</label>
                            <input v-model="post.googlebooks" placeholder="GoogleBooksURL" class="form-control">
                        </div>
                        </span>
                    </div>
                    <p class="modal_checkbox"><input v-model="post.introductory" type="checkbox" name="checkbox" />
                        入門書 </p>
                    <div class="form-group">
                        <label class="label-left-margin">評価点</label>
                        <input v-model="post.evaluation" placeholder="評価点" class="form-control">
                    </div>
                    <div v-if="error.search_point">
                        <div style="color:red;">{{ error.search_point }}</div>
                    </div>
                    <div class="form-group">
                        <label class="label-left-margin">検索件数
                            <span
                                v-if="post.classificationcode == 1">ブログ</span>　{{post.title}}　{{post.publisher}}　{{post.author}}</label>
                        <input v-model="post.search_point" placeholder="検索件数" class="form-control">
                    </div>
                    <div v-if="error.evaluation">
                        <div style="color:red;">{{ error.evaluation }}</div>
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
                    googlebooks:'',
                    publication_date: '',
                    introductory: false,
                    search_point: '',
                    evaluation: '',  
                },
                error: {
                    title: "",
                    photo: '',
                    publisher: '',
                    author: '',
                    photo: '',
                    classificationcode: '',
                    category_code1: '',
                    official_site: '',
                    amazon: '',
                    publication_date: '',
                    search_point: '',
                    evaluation: '',
                    message: '入力して下さい'
                },
                category: '',
                categories: '',
                admin_status: '',
                query: '',
                items: [],
                layLegendTittle:"説明文を表示する",
                legend:"legendUnDisplay"
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
                    this.post.publication_date != '' &&
                    this.post.search_point != '' &&
                    this.post.evaluation != ''
                ) {
                    if (this.$store.dispatch('books/createBook', this.post)) {
                        this.post = {}
                        this.error = {}
                        this.$store.dispatch('books/fetchBooks')
                        this.$store.dispatch('books/fetchBooks')
                        this.closeModal()
                    } else {
                        alert('データの登録に失敗しました。文字の長さ等のご確認をお願いします')
                    }
                } else {
                    if (this.post.title == '') {
                        this.error.title = this.error.message
                    }
                    if (this.post.photo == '') {
                        this.error.photo = this.error.message
                    }
                    if (this.post.author == '') {
                        this.error.author = this.error.message
                    }
                    if (this.post.publisher == '') {
                        this.error.publisher = this.error.message
                    }
                    if (this.post.official_site == '') {
                        this.error.official_site = this.error.message
                    }
                    if (this.post.classificationcode == '') {
                        this.error.classificationcode = this.error.message
                    }
                    if (this.post.category_code1 == '') {
                        this.error.category_code1 = this.error.message
                    }
                    if (this.post.publication_date == '') {
                        this.error.publication_date = this.error.message
                    }
                    if (this.post.search_point == '') {
                        this.error.search_point = this.error.message
                    }
                    if (this.post.evaluation == '') {
                        this.error.evaluation = this.error.message
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
            },
            serach_click: function (id) {
                let item = this.items[id]
                this.post.title = item.volumeInfo.title
                this.post.publisher = item.volumeInfo.publisher
                this.post.author = item.volumeInfo.authors[0]
                this.post.description = item.volumeInfo.description
                this.post.publication_date = item.volumeInfo.publishedDate
                this.post.googlebooks = item.volumeInfo.infoLink
                this.post.photo = item.volumeInfo.imageLinks.thumbnail
                this.post.classificationcode = 1
                this.$bvModal.show('input-modal')
            },
            getResult: async function () {
                if (this.query) {
                    axios.get("https://www.googleapis.com/books/v1/volumes?q=title" + this.query)
                    .then(response => {
                        this.items = response.data.items;
                    })
                    .catch(error => {
                        alert("取り込みに失敗しました")
                    })
                }
            },
            displayLegend:function(){
                if(this.layLegendTittle == "説明文を表示する"){
                    this.layLegendTittle = "説明文を非表示";
                    this.legend="legendDisplay";
                }else{
                    this.layLegendTittle = "説明文を表示する"
                    this.legend="legendUnDisplay";
                }
            }
        }
    }
</script>

<style lang="scss" scoped>
    .legendDisplay{
        margin-left:0px; 
    }
    .legendUnDisplay{
        margin-left:0px; 
        display:none;
    }
    .legendBox {
        width:50%;
        padding: 0.5em 1em;
        margin: 0 0;
        background: #f0f7ff;
        border: dashed 2px #5b8bd0;/*点線*/
    }
    .legendBox li {
        margin: 0; 
        padding: 0;
    }
    .search_input {
        border: 2px #ff0000 double;
        width: 300px;
    }

    img {
        width: 100%;
        height: 400px;
        object-fit: cover;
        margin-bottom: 10px;
    }

    .container {
        width: 90%;
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

    .display-none {
        display: none;
    }

    .label-left-margin {
        margin-left: 5px;
    }

    .modal_checkbox {
        margin-left: 20px;
    }
</style>