<template>
    <div id="app">
        <span style="display:none">{{ i = 0 }}</span>
        <span v-for="category in categories_rankings">
            <button @click="toCategory(category.id)" class="btn btn-secondary top_link">{{ category.name }}</button>
            <span style="display:none">{{ i = i +1 }}</span>
        </span>
        <div v-if="mode==16">
            <button @click="changeMode(2)" class="btn btn-warning limit_link">全て表示</button>
        </div>
        <div v-else>
            <button @click="changeMode(1)" class="btn btn-warning limit_link">初期項目毎16件に戻す</button>
        </div>
        <span v-for="category in categories_rankings">
            <div><span class="category_title">{{category.name}}</span><a name :id="category.id"></a>
            <span @click="scrollTop()">先頭に戻る</span></div>
            <table style="border-color: #ff0000;">
                <tr>
                    <span v-for="book in books" :key="book.id">
                        <span v-if="book.category_code1 == category.id && book.category_rank<=mode">
                            <td width="180px" height="550px" class="td_style">
                                <div class="td_inner">
                                    <p class="photo_box">
                                        <span v-if="book.photo">
                                            <img :src="book.photo" class="photo_just" />
                                        </span>
                                    </p>
                                    <p class="menu-title">
                                        <span class="badge badge-dark">{{ book.category_rank }}位</span>
                                        <span v-if="book.total_point>=70" class="badge badge-success">高評価</span>
                                        <router-link :to="`books/detail/${book.id}`">{{book.title}}</router-link>
                                        <span v-if="book.introductory" class="badge badge-info">入門書</span>
                                        <span v-if="admin_status == true" @click="deleteBook(book.id)" class="badge badge-danger">削除</span>
                                    </p>
                                    <P>
                                        <span v-if="book.amazon">
                                            <a :href="book.amazon" target="_blank" class="btn btn-outline-danger site_link">Amazon</a>
                                        </span>
                                        <span v-if="book.official_site">
                                            <a :href="book.official_site" target="_blank" class="btn btn-outline-info site_link">公式</a>
                                        </span> 
                                    </P>
                                    <p>{{ book.publisher }}</p>
                                    <p>{{ book.author }}</p>
                                    <p>
                                        <span style="color:red">{{book.publication_date}} 刊</span><br />
                                        <span v-if="book.classificationcode" class="badge badge-pill badge-secondary classificationcode_wide">
                                            {{classificationcodes[book.classificationcode].name}}
                                        </span>
                                        <span v-if="book.category_code1" class="badge badge-warning">
                                            {{categories[book.category_code1-1].name}}
                                        </span>
                                        <span v-if="book.category_code2" class="badge badge-info">
                                            {{categories[book.category_code2-1].name}}
                                        </span>
                                        <span v-if="book.category_code3" class="badge badge-dark">
                                            {{categories[book.category_code3-1].name}}
                                        </span>
                                    </p>
                                </div>
                            </td>
                        </span>
                    </span>
                </tr>
            </table>
        </span>
    </div>
</template>

<script>
    import axios from 'axios';
    import setting from '../setting.js';

    export default {
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
                    user_id:''
                },
                category: '',
                categories: '',
                categories_rankings:'',
                category_num: '',
                classificationcodes:'',
                admin_status:'',
                ranking:'',
            }
        },
        computed: {
            books() {
                return this.$store.getters['books/books']
                return this.$store.getters['books/books']
            },
            mode(){
                return this.$store.getters['books/mode']
            }
        },
        mounted() {
            this.setBooks();
            this.categories = setting.func1();
            this.categories_rankings = setting.func1();
            this.sortedCategoriesByRanking();
            this.classificationcodes = setting.func2();
            axios.get('/api/users/1')
            .then(response => (
                this.post.user_id = response.data.id,
                this.admin_status = response.data.admin
            ))
            this.limit = 0
        },
        methods: {
            setBooks: function () {
                const category_id = this.category
                this.$store.dispatch('books/fetchBooks')
                //this.$store.dispatch('books/fetchBooks',category_id)
            },
            deleteBook:function(id) {
                if (window.confirm("NO." + id + "を本当に削除しますか？※削除すれば画面更新がかかります")){
                    if(this.$store.dispatch('books/deleteBook',id)){
                        window.location.reload();
                    }else{
                        alert("削除に失敗しました")
                    }
                }
            },
            toCategory:function(id){
                window.location.href = '/#' + id;
            },
            sortedCategoriesByRanking() {
                return this.categories_rankings.sort((a, b) => {
                return a.ranking - b.ranking;
                });
            },
            scrollTop: function(){
                window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                });
            },
            changeMode(id) {
                this.$store.dispatch('books/changeMode',id)
            }
        },
    }
</script>

<style lang="scss" scoped>
    .top_link{
        width:110px;
        margin:0px 5px 10px 0;
    }

    .category_title{
        margin: 10px 30px 10px 10px;
        font-size:25px;
    }

    .td_style{
        background-color: #f7f7f7; 
        border:3px white solid;
    }
    
    .photo_box {
        margin: 2px 0.5px 0.5px 0.5px;
        padding: 0px;
        height: 250px;
        padding:2px;
    }

    .photo_just {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 160px;
        height: auto;
    }

    .td_inner {
        padding: 0.5em 0.5em;
        margin: 1px;
    }

    .td_inner p {
        margin: 0;
        padding: 0.5px;
    }

    .classificationcode_wide{
        width:55px;
    }

    .limit_link{
        width:200px;
        margin: 5px 5px 10px 0;
    }
    
    .site_link{
        margin: 5px 5px 0 0;
    }
</style>