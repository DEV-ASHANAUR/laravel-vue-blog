import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)
import firstPage from './components/pages/firstVuePage.vue'
import usecom from './vuex/usecom.vue'
import home from './components/pages/home.vue'
import adminUser from './admin/pages/adminUser.vue'
import tag from './admin/pages/tag.vue'
import category from './admin/pages/category.vue'
const routes = [
    
    {
        path: '/',
        component: home
    },
    {
        path: '/admin-user',
        component: adminUser
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
        path: '/test-vuex',
        component: usecom
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