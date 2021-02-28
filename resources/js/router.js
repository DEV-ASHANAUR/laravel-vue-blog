import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)
import firstPage from './components/pages/firstVuePage.vue'
import usecom from './vuex/usecom.vue'
import home from './components/pages/home.vue'
import adminUser from './admin/pages/adminUser.vue'
import role from './admin/pages/role.vue'
import assignRole from './admin/pages/assignRole.vue'
import tag from './admin/pages/tag.vue'
import category from './admin/pages/category.vue'
import login from './admin/pages/login.vue'
const routes = [
    
    {
        path: '/',
        component: home,
        name: '/'
    },
    {
        path: '/role',
        component: role,
        name: 'role'
    },
    {
        path: '/assignRole',
        component: assignRole,
        name: 'assignRole'
    },
    {
        path: '/adminUser',
        component: adminUser,
        name: 'adminUser'
    },
    {
        path: '/tag',
        component: tag,
        name: 'tag'
    },
    {
        path: '/category',
        component: category,
        name: 'category'
    },
    {
        path: '/login',
        component: login
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