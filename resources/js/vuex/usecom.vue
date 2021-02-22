<template>
    <div>
        <div class="content">
			<div class="container-fluid">
                <h1>Hello Want to shown all component here</h1>
                <h2>Master of counter is : {{ counter }}</h2>
                <div> <comA></comA> </div>
                <div> <comB></comB> </div>
                <div> <comC></comC> </div>
                <Button type="info" @click="changeCounter">change the counter</Button>
            </div>
        </div>
    </div>
</template>

<script>
import comA from './comA'
import comB from './comB'
import comC from './comC'
import {mapGetters} from 'vuex'
export default {
    methods : {
        changeCounter(){
            this.$store.dispatch('changeCouterAction',1)
            // this.$store.commit('changethecounter',1)
        }
    },
    computed : {
        ...mapGetters({
            'counter' : 'getCounter'
        })
    },
    created() {
        console.log(this.$store.state.counter);
    },
    components:{
        comA,
        comB,
        comC
    }
}
</script>