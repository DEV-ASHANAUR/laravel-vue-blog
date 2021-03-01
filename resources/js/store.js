import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

export default new Vuex.Store({
    state : {
        counter : 1000,
        user : false,
        userPermission:null
    },
    getters : {
        getCounter(state){
            return state.counter
        },
        getUser(state){
            return state.user
        },
        getUserPermission(state){
            return state.userPermission
        }
    },
    mutations: {
        changethecounter(state,data){
            state.counter += data 
        },
        updateUser(state,data){
            state.user = data
        },
        setUserPermission(state,data){
            state.userPermission = data
        }
    },
    actions : {
        changeCouterAction({commit},data){
            commit('changethecounter',data)
        },
    }

})