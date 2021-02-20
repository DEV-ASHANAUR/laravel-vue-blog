<template>
    <div>
       <div class="content">
			<div class="container-fluid">	
				<!--~~~~~~~ TABLE ONE ~~~~~~~~~-->
				<div class="_1adminOverveiw_table_recent _box_shadow _border_radious _mar_b30 _p20">
					<p class="_title0">Categories <Button @click="addModal=true"><Icon type="md-add"></Icon> Add Category</Button> </p>

					<div class="_overflow _table_div">
						<table class="_table">
								<!-- TABLE TITLE -->
							<tr>
								<th>Id</th>
								<th>Tag</th>
								<th>Created at</th>
								<th>Action</th>
							</tr>
								<!-- TABLE TITLE -->
								<!-- ITEMS -->
							<tr v-for="(tag,i) in tags" :key="i">
								<td>{{ i+1 }}</td>
								<td class="_table_name">{{ tag.tagName }}</td>
								<td>{{ tag.created_at }}</td>
								<td>
									<Button type="info" @click="showEditModal(tag,i)">Edit</Button>
									<Button type="error" @click="showDeletingModel(tag,i)" :loading="tag.isDeleting">Delete</Button>
									
								</td>
							</tr>
							<!-- ITEMS -->
						</table>
					</div>
					<!-- tag add model -->
					<Modal
						v-model="addModal"
						:mask-closable="false"
						:closable="false"
						title="Add Category"
						>
						<Input v-model="data.tagName" placeholder="Enter Category name" />
                        <div class="space"></div>
                        <Upload
                            type="drag"
                            :headers="{'x-csrf-token':token}"
                            action="/app/cat_icon"
                            >
                            <div style="padding: 20px 0">
                                <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                <p>Click or drag files here to upload</p>
                            </div>
                        </Upload>
						<div slot="footer">
							<Button type="default" @click="addModal=false">Close</Button>
							<Button @click="addTag" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Adding..':'Add Category' }}</Button>
						</div>
					</Modal>
					<!-- tag add model end -->
					<!-- tag edit model start -->
					<Modal
						v-model="editModal"
						:mask-closable="false"
						:closable="false"
						title="Edit Tag"
						>
						<Input v-model="editData.tagName" placeholder="Enter tag name" />
						<div slot="footer">
							<Button type="default" @click="editModal=false">Close</Button>
							<Button @click="EditTag" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Saving..':'Save Tag' }}</Button>
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
				tagName: ''
			},
			editData:{
				tagName: ''
			},
			addModal : false,
			editModal: false,
			isAdding : false,
			tags: [],
			index : -1,
			isDeleting:false,
			showDeleteModel:false,
			deletingIndex:-1,
			deleteItem:{},
            token:''
		}	
	},
	methods : {
		async addTag(){
			this.isAdding = true
			if(this.data.tagName.trim()==''){
				this.isAdding = false
				return this.e('Tag name is required');
			}else{
				const res = await this.callApi('post','/app/create_tag',this.data)
				if(res.status == 201){
					this.s("Tag has been Save Successfully")
					this.tags.unshift(res.data)
					this.data.tagName =''
					this.isAdding = false
					this.addModal = false

				}else{
					if(res.status == 422){
						if(res.data.errors.tagName){
							this.e(res.data.errors.tagName[0])
						}
						this.isAdding = false
					}else{
						this.swr()
						this.isAdding = false
					}
					
				}
			}
		},
		async EditTag(){
			this.isAdding = true
			if(this.editData.tagName.trim()==''){
				this.isAdding = false
				return this.e('Tag name is required');
			}else{
				const res = await this.callApi('post','/app/edit_tag',this.editData)
				if(res.status == 200){
					this.tags[this.index].tagName = this.editData.tagName
					this.s("Tag has been Edit Successfully")
					this.isAdding = false
					this.editModal = false

				}else{
					if(res.status == 422){
						if(res.data.errors.tagName){
							this.e(res.data.errors.tagName[0])
						}
						this.isAdding = false
					}else{
						this.swr()
						this.isAdding = false
					}
					
				}
			}
		},
		showEditModal(tag,index){
			let obj = {
				id : tag.id,
				tagName : tag.tagName
			}
			this.editData = obj
			this.editModal = true
			this.index = index

		},
		async deleteTag(){
			// if(!confirm('Are you sure!you want to delete this tag?')) return
			// this.$set(tag, 'isDeleting', true)
			this.isDeleting = true
			const res  = await this.callApi('post','/app/delete_tag',this.deleteItem)
			if(res.status == 200){
				this.tags.splice(this.deletingIndex,1)
				this.s("Tag has been deleted successfully")
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
        this.token = window.Laravel.csrfToken
		const res = await this.callApi('get','/app/get_tag');
		// console.log(res);
		if(res.status==200){
			this.tags = res.data
		}else{
			this.swr()
		}
	},
}
</script>