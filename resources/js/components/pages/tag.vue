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
								<th>Id</th>
								<th>Tag</th>
								<th>Created at</th>
								<th>Action</th>
							</tr>
								<!-- TABLE TITLE -->


								<!-- ITEMS -->
							<tr v-for="(tag,i) in tags" :key="i" v-if="tags.length">
								<td>{{ i+1 }}</td>
								<td class="_table_name">{{ tag.tagName }}</td>
								<td>{{ tag.created_at }}</td>
								<td>
									<Button type="info">Edit</Button>
									<Button type="error">Delete</Button>
									
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
						title="Add Tag"
						>
						<Input v-model="data.tagName" placeholder="Enter tag name" />
						<div slot="footer">
							<Button type="default" @click="addModal=false">Close</Button>
							<Button @click="addTag" type="primary" :disabled="isAdding" :loading="isAdding">{{ isAdding ? 'Adding..':'Add Tag' }}</Button>
						</div>
					</Modal>

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
			addModal : false,
			isAdding : false,
			tags: [],
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
					this.s("Tag Save Successfully")
					this.tags.unshift(res.data)
					this.data.tagName =''
					this.isAdding = false
					this.addModal = false

				}else{
					if(res.status == 422){
						if(res.data.errors.tagName){
							this.e(res.data.errors.tagName[0])
						}
					}else{
						this.swr()
					}
					
				}
			}
		}
	},
	async created() {
		const res = await this.callApi('get','/app/get_tag');
		console.log(res);
		if(res.status==200){
			this.tags = res.data
		}else{
			this.swr()
		}
	},
}
</script>