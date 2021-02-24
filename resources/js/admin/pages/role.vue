<template>
    <div>
       <div class="content">
			<div class="container-fluid">	
				<!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
				<div class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
					<p class="_title0">Tags <Button @click="addModal=true"><Icon type="md-add"></Icon> Add Tag</Button> </p>

					<div class="_overflow _table_div">
						<table class="_table">
								<!-- TABLE TITLE -->
							<tr>
								<th>Si</th>
								<th>Tag</th>
								<th>Created at</th>
								<th>Action</th>
							</tr>
								<!-- TABLE TITLE -->
								<!-- ITEMS -->
							<tr v-if="preLoader">
								<td colspan="4" style="text-align:center"><Button type="error" :loading="preLoader">Loading..</Button></td>
							</tr>
							
							<tr v-for="(role,i) in roles" :key="i">
								<td>{{ i+1 }}</td>
								<td style="text-transform:capitalize">{{ role.roleName }}</td>
								<td>{{ role.created_at }}</td>
								<td>
									<Button type="info" @click="showEditModal(role,i)">Edit</Button>
									<Button type="error" @click="showDeletingModel(role,i)" :loading="role.isDeleting">Delete</Button>
									
								</td>
							</tr>
							<tr v-if="roles.length == 0 && !preLoader">
								<td colspan="4" style="text-align:center">No data found!</td>
							</tr>
							<!-- ITEMS -->
						</table>
					</div>
					<!-- tag add model -->
					<Modal
						v-model="addModal"
						:mask-closable="false"
						:closable="false"
						title="Add Tag"
						>
						<Input v-model="data.roleName" placeholder="Enter role name" />
						<div slot="footer">
							<Button type="default" @click="addModal=false">Close</Button>
							<Button @click="add" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Adding..':'Add Role' }}</Button>
						</div>
					</Modal>
					<!-- tag add model end -->
					<!-- tag edit model start -->
					<Modal
						v-model="editModal"
						:mask-closable="false"
						:closable="false"
						title="Edit Role"
						>
						<Input v-model="editData.roleName" placeholder="Enter tag name" />
						<div slot="footer">
							<Button type="default" @click="editModal=false">Close</Button>
							<Button @click="Edit" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Saving..':'Save Role' }}</Button>
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
							<p>Are you sure! You Want to delete this tag? </p>
						</div>
						<div slot="footer">
							<Button type="error" size="large" long :disabled="isDeleting" :loading="isDeleting" @click="deleteTag">Delete</Button>
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
				roleName: ''
			},
			editData:{
				roleName: ''
			},
			addModal : false,
			editModal: false,
			isAdding : false,
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
		async add(){
			this.isAdding = true
			if(this.data.roleName.trim()==''){
				this.isAdding = false
				return this.e('Role name is required');
			}else{
				const res = await this.callApi('post','/app/create_role',this.data)
				if(res.status == 201){
					this.s("Role has been Save Successfully")
					this.roles.unshift(res.data)
					this.data.roleName =''
					this.isAdding = false
					this.addModal = false

				}else{
					if(res.status == 422){
						if(res.data.errors.roleName){
							this.e(res.data.errors.roleName[0])
						}
						this.isAdding = false
					}else{
						this.swr()
						this.isAdding = false
					}
					
				}
			}
		},
		async Edit(){
			this.isAdding = true
			if(this.editData.roleName.trim()==''){
				this.isAdding = false
				return this.e('Tag name is required');
			}else{
				const res = await this.callApi('post','/app/edit_role',this.editData)
				if(res.status == 200){
					this.roles[this.index].roleName = this.editData.roleName
					this.s("Role has been Edit Successfully")
					this.isAdding = false
					this.editModal = false

				}else{
					if(res.status == 422){
						if(res.data.errors.roleName){
							this.e(res.data.errors.roleName[0])
						}
						this.isAdding = false
					}else{
						this.swr()
						this.isAdding = false
					}
					
				}
			}
		},
		showEditModal(role,index){
			let obj = {
				id : role.id,
				roleName : role.roleName
			}
			this.editData = obj
			this.editModal = true
			this.index = index

		},
		async deleteTag(){
			// if(!confirm('Are you sure!you want to delete this tag?')) return
			// this.$set(tag, 'isDeleting', true)
			this.isDeleting = true
			const res  = await this.callApi('post','/app/delete_role',this.deleteItem)
			if(res.status == 200){
				this.roles.splice(this.deletingIndex,1)
				this.s("Role has been deleted successfully")
			}else{
				this.swr();
			}
			this.isDeleting = false
			this.showDeleteModel = false
		},
		showDeletingModel(role,i){
			this.deleteItem = role
			this.deletingIndex = i
			this.showDeleteModel = true
		}
	},
	async created() {
		this.preLoader = true
		const res = await this.callApi('get','/app/get_role');
		this.preLoader = false
		// console.log(res);
		if(res.status==200){
			this.roles = res.data
		}else{
			this.swr()
		}
	},
}
</script>