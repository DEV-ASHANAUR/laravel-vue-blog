import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

export default new Vuex.Store({
    state : {
        counter : 1000
    },
    getters : {
        getCounter(state){
            return state.counter
        }
    },
    mutations: {
        changethecounter(state,data){
            state.counter += data 
        }
    },
    actions : {
        changeCouterAction({commit},data){
            commit('changethecounter',data)
        }
    }

})