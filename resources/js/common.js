import {mapGetters} from 'vuex'
import moment from 'moment';
export default{
    data(){
        return {

        }
    },
    methods: {
        async callApi(method,url,dataObj){
            try {
                return await axios({
                    method: method,
                    url: url,
                    data: dataObj
                  });
            } catch(e) {
                return e.response
            }
        },
        i(desc, title="Hey") {
            this.$Notice.info({
                title: title,
                desc: desc
            });
        },
        s(desc, title="Great!") {
            this.$Notice.success({
                title: title,
                desc: desc
            });
        },
        w(desc, title="Oops!") {
            this.$Notice.warning({
                title: title,
                desc: desc
            });
        },
        e(desc, title="Oops!") {
            this.$Notice.error({
                title: title,
                desc: desc
            });
        },
        swr(desc="Something went worng! please try again", title="Oops!") {
            this.$Notice.error({
                title: title,
                desc: desc
            });
        },
        format_date(value){
            if (value) {
              return moment(String(value)).format('DD-MM-YYYY hh:mm A')
             }
         },
        checkUserPermission(key){
            if(!this.userPermission) return true
            let isPermitted = false
            for(let d of this.userPermission){
                if(this.$route.name == d.name){
                    if(d[key]){
                        isPermitted = true
                        break
                    }else{
                        break
                    }
                }
            }
            return isPermitted
        }
    },
    computed : {
        ...mapGetters({
            'userPermission': 'getUserPermission'
        }),
        isReadPermission(){
           return this.checkUserPermission('read')
        },
        isWritePermission(){
            return this.checkUserPermission('write')
        },
        isUpdatePermission(){
            return this.checkUserPermission('update')
        },
        isDeletePermission(){
            return this.checkUserPermission('delete')
        },
    }
}