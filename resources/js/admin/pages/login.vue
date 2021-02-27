<template>
    <div>
        <div class="container">
			<div class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20 col-md-4">
                <div class="login_header">
                    <h2>Login to The Dashboard</h2>
                </div>
                <div class="space">
                    <Input v-model="data.email" type="email" placeholder="Enter Email" />
                </div>
                <div class="space">
                    <Input v-model="data.password" type="password" placeholder="********" />
                </div>
                <div class="login_footer">
                    <Button :disabled="islogging" :loading="islogging" type="primary" @click="login">Login</Button>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data(){
        return {
            data : {
                email: 'ashanour009@gmail.com',
                password: '12345678'
            },
            islogging: false
        }
    },
    methods: {
        async login(){
            
			if(this.data.email.trim()==''){
				this.islogging = false
				return this.e('Email is required');
			}
            if(this.data.password.trim()==''){
				this.islogging = false
				return this.e('Password is required');
			}
            if(this.data.password.length < 6){
				this.islogging = false
				return this.e('Incorrect login details');
			}
            this.islogging = true
            const res = await this.callApi('post','/app/admin_login',this.data)
            console.log(res)
            if(res.status == 200){
                this.s(res.data.msg)
                window.location = '/'
            }else{
                if(res.status == 401){
                    this.i(res.data.msg)
                }else if(res.status == 422){
                    for(let i in res.data.errors){
                        this.e(res.data.errors[i][0])
                    }
                }else{
                    this.swr()
                }
            }
            this.islogging = false
        }
    }
}
</script>

<style scoped>
    ._1adminOverveiw_table_recent {
        margin: 0 auto;
        margin-top: 200px;
    }
    .login_header{
        text-align: center;
        margin-bottom: 25px;
    }
</style>