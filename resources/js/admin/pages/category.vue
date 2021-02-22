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
								<th>Si</th>
								<th>Icon</th>
								<th>Tag</th>
								<th>Created at</th>
								<th>Action</th>
							</tr>
								<!-- TABLE TITLE -->
								<!-- ITEMS -->
							<tr v-if="preLoader">
								<td colspan="5" style="text-align:center"><Button type="error" :loading="preLoader">Loading..</Button></td>
							</tr>	
							<tr v-for="(category,i) in categoryList" :key="i">
								<td>{{ i+1 }}</td>
								<td class="iconImage">
									<img :src="category.iconImage" />
								</td>
								<td style="text-transform:capitalize">{{ category.categoryName }}</td>
								<td>{{ category.created_at }}</td>
								<td>
									<Button type="info" @click="showEditModal(category,i)">Edit</Button>
									<Button type="error" @click="showDeletingModel(category,i)" :loading="category.isDeleting">Delete</Button>
									
								</td>
							</tr>
							<tr v-if="categoryList.length == 0 && !preLoader">
								<td colspan="5" style="text-align:center">No data found!</td>
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
						<Input v-model="data.categoryName" placeholder="Enter Category name" />
                        <div class="space"></div>
                        <Upload
							ref="uploads"
                            type="drag"
                            :headers="{'x-csrf-token':token,'X-Requested-With': 'XMLHttpRequest'}"
							:on-success="handleSuccess"
							:on-error="handleError"
							:format="['jpg','jpeg','png']"
							:max-size="2048"
							:on-format-error="handleFormatError"
							:on-exceeded-size="handleMaxSize"
                            action="/app/cat_icon"
                            >
                            <div style="padding: 20px 0">
                                <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                <p>Click or drag files here to upload</p>
                            </div>
                        </Upload>
						<div class="demo-upload-list" v-if="data.iconImage">
							<img :src="`/uploads/category/${data.iconImage}`" />
							<div class="demo-upload-list-cover">
								<Icon type="ios-trash-outline" @click="deleteImage"></Icon>
							</div>
						</div>
						<div slot="footer">
							<Button type="default" @click="addModal=false">Close</Button>
							<Button @click="addCategory" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Adding..':'Add Category' }}</Button>
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
						<Input v-model="editData.categoryName" placeholder="Enter Category name" />
                        <div class="space"></div>
                        <Upload
							v-show="isIconImageNew"
            				ref="editDataUploads"
                            type="drag"
                            :headers="{'x-csrf-token':token,'X-Requested-With': 'XMLHttpRequest'}"
							:on-success="handleSuccess"
							:on-error="handleError"
							:format="['jpg','jpeg','png']"
							:max-size="2048"
							:on-format-error="handleFormatError"
							:on-exceeded-size="handleMaxSize"
                            action="/app/cat_icon"
                            >
                            <div style="padding: 20px 0">
                                <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                <p>Click or drag files here to upload</p>
                            </div>
                        </Upload>
						<div class="demo-upload-list" v-if="editData.iconImage">
							<img :src="`${editData.iconImage}`" />
							<div class="demo-upload-list-cover">
								<Icon type="ios-trash-outline" @click="deleteEditImage"></Icon>
							</div>
						</div>
						<div slot="footer">
							<Button type="default" @click="closeEditModal">Close</Button>
							<Button @click="EditCategory" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Editing..':'Edit Category' }}</Button>
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
							<p>Are you sure! You Want to delete this Category? </p>
						</div>
						<div slot="footer">
							<Button type="error" size="large" long :disabled="isDeleting" :loading="isDeleting" @click="deleteCategory">Delete</Button>
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
				categoryName: '',
				iconImage: ''
			},
			editData:{
				categoryName: '',
				iconImage: ''
			},
			addModal : false,
			editModal: false,
			isAdding : false,
			categoryList: [],
			index : -1,
			isDeleting:false,
			showDeleteModel:false,
			deletingIndex:-1,
			deleteItem:{},
            token:'',
			preLoader:false,
			isIconImageNew:false,
			isEditingItem:false
		}	
	},
	methods : {
		async addCategory(){
			this.isAdding = true
			if(this.data.categoryName.trim()==''){
				this.isAdding = false
				return this.e('Category name is required');
			}
			if(this.data.iconImage.trim()==''){
				this.isAdding = false
				return this.e('IconImage is required');
			}
			this.data.iconImage = `/uploads/category/${this.data.iconImage}`
			const res = await this.callApi('post','/app/create_category',this.data)
			if(res.status == 201){
				this.s("Category has been Save Successfully")
				this.categoryList.unshift(res.data)
				this.data.categoryName =''
				this.data.iconImage =''
				this.$refs.uploads.clearFiles()
				this.isAdding = false
				this.addModal = false

			}else{
				if(res.status == 422){
					if(res.data.errors.categoryName){
						this.e(res.data.errors.categoryName[0])
					}
					if(res.data.errors.iconImage){
						this.e(res.data.errors.iconImage[0])
					}
					this.isAdding = false
				}else{
					this.swr()
					this.isAdding = false
				}
				
			}
		},
		async EditCategory(){
			this.isAdding = true
			if(this.editData.categoryName.trim()==''){
				this.isAdding = false
				return this.e('Category name is required');
			}
			if(this.editData.iconImage.trim()==''){
				this.isAdding = false
				return this.e('Icon Image is required');
			}
			const res = await this.callApi('post','/app/edit_category',this.editData)
			if(res.status == 200){
				this.categoryList[this.index].categoryName = this.editData.categoryName
				this.s("Category has been Edit Successfully")
				this.isAdding = false
				this.editModal = false
				this.isEditingItem = false
			}else{
				if(res.status == 422){
					if(res.data.errors.categoryName){
						this.e(res.data.errors.categoryName[0])
					}
					if(res.data.errors.iconImage){
						this.e(res.data.errors.iconImage[0])
					}
					this.isAdding = false
				}else{
					this.swr()
					this.isAdding = false
				}
				
			}
		},
		showEditModal(category,index){
			// let obj = {
			// 	id : tag.id,
			// 	tagName : tag.tagName
			// }
			this.editData = category
			this.editModal = true
			this.index = index
			this.isEditingItem = true

		},
		async deleteCategory(){
			// if(!confirm('Are you sure!you want to delete this tag?')) return
			// this.$set(tag, 'isDeleting', true)
			this.isDeleting = true
			const res  = await this.callApi('post','/app/delete_category',this.deleteItem)
			if(res.status == 200){
				this.categoryList.splice(this.deletingIndex,1)
				this.s("Category has been deleted successfully")
			}else{
				this.swr();
			}
			this.isDeleting = false
			this.showDeleteModel = false
		},
		showDeletingModel(category,i){
			this.deleteItem = category
			this.deletingIndex = i
			this.showDeleteModel = true
		},
		handleSuccess (res, file) {
			if(this.isEditingItem){
				res = `/uploads/category/${res}`;
				this.editData.iconImage = res
			}else{
				this.data.iconImage = res
			}
		},
		handleError (res, file) {
			// console.log('res',res)
			// console.log('file',file)
			this.$Notice.warning({
				title: 'The file format is incorrect',
				desc: `${file.errors.file.length ? file.errors.file[0]:'something went worng!'}`
			});

		},
		handleFormatError (file) {
			this.$Notice.warning({
				title: 'The file format is incorrect',
				desc: 'File format of ' + file.name + ' is incorrect, please select jpg or png.'
			});
		},
		handleMaxSize (file) {
			this.$Notice.warning({
				title: 'Exceeding file size limit',
				desc: 'File  ' + file.name + ' is too large, no more than 2M.'
			});
		},
		async deleteImage(){
			let image = this.data.iconImage
			this.data.iconImage =''
			this.$refs.uploads.clearFiles()
			const res = await this.callApi('post','/app/delete_image',{imageName:image})
			if(res.status!=200){
				this.data.iconImage = image
				this.swr()
			}
		},
		async deleteEditImage(){
			this.isIconImageNew = true;
			let image = this.editData.iconImage
			this.editData.iconImage =''
			this.$refs.editDataUploads.clearFiles()
			const res = await this.callApi('post','/app/delete_editimage',{imageName:image})
			if(res.status!=200){
				this.editData.iconImage = image
				this.swr()
			}
		},
		closeEditModal() {
			this.isEditingItem = false;
			this.editModal = false;
		}
	},
	async created() {
		this.preLoader = true
        this.token = window.Laravel.csrfToken
		const res = await this.callApi('get','/app/get_category');
		this.preLoader = false
		if(res.status==200){
			this.categoryList = res.data
		}else{
			this.swr()
		}
	},
}
</script>
<style scoped>
	.demo-upload-list{
        display: inline-block;
        width: 60px;
        height: 60px;
        text-align: center;
        line-height: 60px;
        border: 1px solid transparent;
        border-radius: 4px;
        overflow: hidden;
        background: #fff;
        position: relative;
        box-shadow: 0 1px 1px rgba(0,0,0,.2);
        margin-right: 4px;
    }
    .demo-upload-list img{
        width: 100%;
        height: 100%;
    }
    .demo-upload-list-cover{
        display: none;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0,0,0,.6);
    }
    .demo-upload-list:hover .demo-upload-list-cover{
        display: block;
    }
    .demo-upload-list-cover i{
        color: #fff;
        font-size: 20px;
        cursor: pointer;
        margin: 0 2px;
    }
	.iconImage{
		width: 100px;
		height: 100px;
	}
</style>