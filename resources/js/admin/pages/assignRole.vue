<template>
    <div>
       <div class="content">
			<div class="container-fluid">	
				<!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
				<div class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
					<p class="_title0"> 
                        Assign Permission
                        <Select v-model="data.id" style="width:300px" placeholder="Select Admin Type" @on-change="changeAdmin">
                            <Option :value="r.id" v-for="(r,i) in roles" :key="i"> {{ r.roleName }} </Option>
                        </Select> 
                    </p>

					<div class="_overflow _table_div">
						<table class="_table">
							<!-- TABLE TITLE -->
							<tr>
								<th>Resource Name</th>
								<th>Read</th>
								<th>Write</th>
                                <th>Update</th>
								<th>Delete</th>
							</tr>
							<!-- TABLE TITLE -->
							<!-- ITEMS -->
							<tr v-for="(res,i) in resources" :key="i">
                                <td> {{ res.resourceName }}</td>
                                <td><Checkbox v-model="res.read">yes</Checkbox></td>
                                <td><Checkbox v-model="res.write">yes</Checkbox></td>
                                <td><Checkbox v-model="res.update">yes</Checkbox></td>
                                <td><Checkbox v-model="res.delete">yes</Checkbox></td>
                            </tr>
							<!-- ITEMS -->
                            <div style="margin-top:10px">
                                <Button type="primary" :loading="isSending" :disabled="isSending" @click="assignRoles">Assign</Button>
                            </div>
						</table>
					</div>
				</div>
			</div>
		</div>
    </div>
</template>

<script>
export default {
	data(){
		return {
			data:{
				id: null
			},
			isSending : false,
            resources: [
                {resourceName: 'Home', read:false,write:false,update:false,delete:false,name:'home'},
                {resourceName: 'Role', read:false,write:false,update:false,delete:false,name:'role'},
                {resourceName: 'Assign Role', read:false,write:false,update:false,delete:false,name:'assignRole'},
                {resourceName: 'Admin User', read:false,write:false,update:false,delete:false,name:'adminUser'},
                {resourceName: 'Tag', read:false,write:false,update:false,delete:false,name:'tag'},
                {resourceName: 'Category', read:false,write:false,update:false,delete:false,name:'category'},
            ],
            defaultResources: [
                {resourceName: 'Home', read:false,write:false,update:false,delete:false,name:'home'},
                {resourceName: 'Role', read:false,write:false,update:false,delete:false,name:'role'},
                {resourceName: 'Assign Role', read:false,write:false,update:false,delete:false,name:'assignRole'},
                {resourceName: 'Admin User', read:false,write:false,update:false,delete:false,name:'adminUser'},
                {resourceName: 'Tag', read:false,write:false,update:false,delete:false,name:'tag'},
                {resourceName: 'Category', read:false,write:false,update:false,delete:false,name:'category'},
            ],
            roles: [],

		}	
	},
	methods : {
		async assignRoles(){
            let data = JSON.stringify(this.resources)
            const res  = await this.callApi('post','app/assign_roles',{'permission':data,'id':this.data.id})
            if(res.status == 200){
                this.s("Roles has been Assign Successfully")
                let index = this.roles.findIndex(role => role.id == this.data.id)
                this.roles[index].permission = data
            }else{
                this.swr()
            }
        },
        changeAdmin(){
            let index = this.roles.findIndex(role => role.id == this.data.id)
            let permission = this.roles[index].permission
            if(!permission){
                this.resources = this.defaultResources
            }else{
                this.resources = JSON.parse(permission)
            }
        }
	},
	async created() {
		const res = await this.callApi('get','/app/get_role');
		if(res.status==200){
			this.roles = res.data
            if(res.data){
                this.data.id = res.data[0].id
                if(res.data[0].permission){
                    this.resources = JSON.parse(res.data[0].permission)
                }
            }
		}else{
			this.swr()
		}
	},
}
</script>