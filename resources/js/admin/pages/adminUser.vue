<template>
    <div>
       <div class="content">
			<div class="container-fluid">	
				<!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
				<div class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
					<p class="_title0">Users <Button @click="addModal=true"><Icon type="md-add"></Icon> Add Admin</Button> </p>

					<div class="_overflow _table_div">
						<table class="_table">
								<!-- TABLE TITLE -->
							<tr>
								<th>Si</th>
								<th>Name</th>
                                <th>Email</th>
                                <th>UserType</th>
								<th>Created at</th>
								<th>Action</th>
							</tr>
								<!-- TABLE TITLE -->
								<!-- ITEMS -->
							<tr v-if="preLoader">
								<td colspan="6" style="text-align:center"><Button type="error" :loading="preLoader">Loading..</Button></td>
							</tr>
							
							<tr v-for="(user,i) in users" :key="i">
								<td>{{ i+1 }}</td>
								<td style="text-transform:capitalize">{{ user.fullName }}</td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.role.roleName }}</td>
								<td>{{ user.created_at }}</td>
								<td>
									<Button type="info" @click="showEditModal(user,i)">Edit</Button>
									<Button type="error" @click="showDeletingModel(user,i)" :loading="user.isDeleting">Delete</Button>
									
								</td>
							</tr>
							<tr v-if="users.length == 0 && !preLoader">
								<td colspan="6" style="text-align:center">No data found!</td>
							</tr>
							<!-- ITEMS -->
						</table>
					</div>
					<!-- tag add model -->
					<Modal
						v-model="addModal"
						:mask-closable="false"
						:closable="false"
						title="Add Admin"
						>
                        <div class="space">
                            <Input type="text" v-model="data.fullName" placeholder="Enter Full Name" />
                        </div>
                        <div class="space">
                            <Input type="email" v-model="data.email" placeholder="Enter Email Address" />
                        </div>
                        <div class="space">
                            <Select v-model="data.role_id" placeholder="Selcet UserType">
                                <Option :value="r.id" v-for="(r,i) in roles" :key="i">{{ r.roleName }}</Option>
                                
                            </Select>
                        </div>
                        <div class="space">
                            <Input type="password" v-model="data.password" placeholder="Enter Password" />
                        </div>
                        <div class="space">
                            <Input type="password" v-model="data.password_confirmation" placeholder="Enter Confirm Password" />
                        </div>
						<div slot="footer">
							<Button type="default" @click="addModal=false">Close</Button>
							<Button @click="addAdmin" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Saveing..':'Save' }}</Button>
						</div>
					</Modal>
					<!-- tag add model end -->
					<!-- tag edit model start -->
					<Modal
						v-model="editModal"
						:mask-closable="false"
						:closable="false"
						title="Edit Admin"
						>
						<div class="space">
                            <Input type="text" v-model="editData.fullName" placeholder="Enter Full Name" />
                        </div>
                        <div class="space">
                            <Input type="email" v-model="editData.email" placeholder="Enter Email Address" />
                        </div>
                        <div class="space">
                            <Select v-model="editData.role_id" placeholder="Selcet UserType">
                                <Option :value="r.id" v-for="(r,i) in roles" :key="i">{{ r.roleName }}</Option>
                            </Select>
                        </div>
						<div slot="footer">
							<Button type="default" @click="editModal=false">Close</Button>
							<Button @click="EditAdmin" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Saving..':'Save' }}</Button>
						</div>
					</Modal>
					<!-- tag edit model end -->
					<!-- tag delete model start -->
					<Modal v-model="showDeleteModel" width="360">
						<p slot="header" style="color:#f60;text-align:center">
							<Icon type="ios-information-circle"></Icon>
							<span>Delete confirmation</span>
						</p>
						<div style="text-align:center">
							<p>Are you sure! You Want to delete this User? </p>
						</div>
						<div slot="footer">
							<Button type="error" size="large" long :disabled="isDeleting" :loading="isDeleting" @click="deleteUser">Delete</Button>
						</div>
					</Modal>
					<!-- tag delete model end -->
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
				fullName: '',
                email: '',
                role_id: null,
                password: '',
                password_confirmation: ''
			},
			editData:{
				fullName: '',
                email: '',
                role_id: '',
			},
			addModal : false,
			editModal: false,
			isAdding : false,
			users: [],
			roles: [],
			index : -1,
			isDeleting:false,
			showDeleteModel:false,
			deletingIndex:-1,
			deleteItem:{},
			preLoader:false,

		}	
	},
	methods : {
		async addAdmin(){
			this.isAdding = true
			if(this.data.fullName.trim()==''){
				this.isAdding = false
				return this.e('FullName is required');
			}
            if(this.data.email.trim()==''){
				this.isAdding = false
				return this.e('Email is required');
			}
            if(this.data.role_id==null){
				this.isAdding = false
				return this.e('Role is required');
			}
            if(this.data.password.trim()==''){
				this.isAdding = false
				return this.e('password is required');
			}
            if(this.data.password_confirmation.trim()==''){
				this.isAdding = false
				return this.e('Confirm Password is required');
			}
            const res = await this.callApi('post','/app/create_admin_user',this.data)
			this.isAdding = false
            if(res.status == 201){
                this.s("Admin User Save Successfully")
				console.log(res.data);
                this.users.unshift(res.data.user)
                this.data = {
                    fullName: '',
                    email: '',
                    role_id: '',
                    password: '',
                    password_confirmation: ''
                }
                this.isAdding = false
                this.addModal = false

            }else{
                if(res.status == 422){
                    if(res.data.errors.fullName){
                        this.e(res.data.errors.fullName[0])
                    }
                    if(res.data.errors.email){
                        this.e(res.data.errors.email[0])
                    }
                    if(res.data.errors.role_id){
                        this.e(res.data.errors.role_id[0])
                    }
                    if(res.data.errors.password){
                        this.e(res.data.errors.password[0])
                        if(res.data.errors.password[1]){
                            this.e(res.data.errors.password[1])
                        }
                    }
                    this.isAdding = false
                }else{
                    this.swr()
                    this.isAdding = false
                }
                
            }
			this.isAdding = false
		},
		async EditAdmin(){
			this.isAdding = true
			if(this.editData.fullName.trim()==''){
				this.isAdding = false
				return this.e('FullName is required');
			}
            if(this.editData.email.trim()==''){
				this.isAdding = false
				return this.e('Email is required');
			}
            if(this.editData.role_id==null){
				this.isAdding = false
				return this.e('UserType is required');
			}
			const res = await this.callApi('post','/app/edit_admin_user',this.editData)
			if(res.status == 200){
				this.users[this.index].fullName = this.editData.fullName
				this.users[this.index].email = this.editData.email
				this.s("Admin User Edit Successfully")
				this.isAdding = false
				this.editModal = false

			}else{
				if(res.status == 422){
					if(res.data.errors.fullName){
                        this.e(res.data.errors.fullName[0])
                    }
                    if(res.data.errors.email){
                        this.e(res.data.errors.email[0])
                    }
                    if(res.data.errors.role_id){
                        this.e(res.data.errors.role_id[0])
                    }
					this.isAdding = false
				}else{
					this.swr()
					this.isAdding = false
				}
				
			}
		},
		showEditModal(user,index){
			let obj = {
				id : user.id,
				fullName : user.fullName,
				email : user.email,
				role_id : user.role_id,
			}
			this.editData = obj
			this.editModal = true
			this.index = index

		},
		async deleteUser(){
			// if(!confirm('Are you sure!you want to delete this tag?')) return
			// this.$set(tag, 'isDeleting', true)
			this.isDeleting = true
			const res  = await this.callApi('post','/app/delete_user',this.deleteItem)
			if(res.status == 200){
				this.users.splice(this.deletingIndex,1)
				this.s("Admin User deleted successfully")
			}else{
				this.swr();
			}
			this.isDeleting = false
			this.showDeleteModel = false
		},
		showDeletingModel(tag,i){
			this.deleteItem = tag
			this.deletingIndex = i
			this.showDeleteModel = true
		}
	},
	async created() {
		this.preLoader = true
		const [res,resRole] = await Promise.all([
			this.callApi('get','/app/get_user_admin'),
			this.callApi('get','/app/get_role')
		])
		this.preLoader = false
		// response user data
		if(res.status==200){
			this.users = res.data
		}else{
			this.swr()
		}
		// response roles data
		if(res.status==200){
			this.roles = resRole.data
		}else{
			this.swr()
		}
	},
}
</script>