import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)
import firstPage from './components/pages/firstVuePage.vue'
import home from './components/pages/home.vue'
import tag from './admin/pages/tag.vue'
import category from './admin/pages/category.vue'
const routes = [
    
    {
        path: '/',
        component: home
    },
    {
        path: '/tag',
        component: tag
    },
    {
        path: '/category',
        component: category
    },
    {
        path: '/my-new-vue-route',
        component: firstPage
    },
]

export default new Router({
    mode:'history',
    routes
})