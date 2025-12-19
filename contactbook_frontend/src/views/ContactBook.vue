<script>
import ContactCard from "@/components/ContactCard.vue";
import InputSearch from "@/components/InputSearch.vue";
import ContactList from "@/components/ContactList.vue";
import contactService from "@/services/contact.service";

export default {
  components: {
    ContactCard,
    InputSearch,
    ContactList,
  },
  data() {
    return {
      contacts: [],
      activeIndex: -1,
      searchText: "",
    };
  },
  
  watch: {
    // Đổi nội dung tìm kiếm thì bỏ chọn mục đang active
    searchText() {
      this.activeIndex = -1;
    },
  },
  computed: {
    // Gom các trường thành chuỗi để tìm kiếm
    contactStrings() {
      return this.contacts.map((contact) => {
        const { name, email, address, phone } = contact;
        return [name, email, address, phone].join(" ").toLowerCase();
      });
    },
    filteredContacts() {
      if (!this.searchText) return this.contacts;
      const text = this.searchText.toLowerCase();
      return this.contacts.filter((_, index) =>
        this.contactStrings[index].includes(text)
      );
    },
    filteredContactsCount() {
      return this.filteredContacts.length;
    },
    activeContact() {
      return this.filteredContacts[this.activeIndex] || null;
    },
  },
  methods: {
    async retrieveContacts() {
      try {
        this.contacts = await contactService.getAll();
        this.activeIndex = -1;
      } catch (error) {
        console.log(error);
      }
    },
    updateActiveIndex(index) {
      this.activeIndex = index;
    },
    async refreshList() {
      await this.retrieveContacts();
      this.activeIndex = -1;
    },
    async removeAllContacts() {
      if (!confirm("Bạn muốn xóa tất cả Liên hệ?")) return;
      try {
        await contactService.deleteAll();
        await this.refreshList();
      } catch (error) {
        console.log(error);
      }
    },
    goToAddContact() {
      this.$router.push({ name: "contact.add" });
    },
  },
  async mounted() {
    await this.refreshList();
  },
};
</script>

<template>
  <div class="page container py-4">
    <div class="row">
      <!-- Ô tìm kiếm -->
      <div class="col-md-10">
        <InputSearch v-model="searchText" @submit="retrieveContacts" />
      </div>
    </div>

    <!-- Danh sách liên hệ -->
    <div class="mt-3 row">
      <div class="col-md-6">
        <h4 class="d-flex align-items-center gap-2">
          <i class="fas fa-address-book"></i>
          Danh bạ
        </h4>

        <ContactList
          v-if="filteredContactsCount > 0"
          :contacts="filteredContacts"
          :active-index="activeIndex"
          @update:activeIndex="updateActiveIndex"
        />
        <p v-else class="empty-message">
          <span v-if="searchText">
            Không tìm thấy liên hệ nào với từ khóa "{{ searchText }}".
          </span>
          <span v-else>Không có liên hệ nào.</span>
        </p>

        <div class="mt-3 row justify-content-around align-items-center">
          <button class="btn btn-sm btn-primary" @click="refreshList">
            <i class="fas fa-redo"></i> Làm mới
          </button>

          <button class="btn btn-sm btn-success" @click="goToAddContact">
            <i class="fas fa-plus"></i> Thêm mới
          </button>

          <button class="btn btn-sm btn-danger" @click="removeAllContacts">
            <i class="fas fa-trash"></i> Xóa tất cả
          </button>
        </div>
      </div>

      <!-- Thông tin chi tiết -->
      <div class="col-md-6" v-if="activeContact">
        <h4>Chi tiết</h4>
        <div class="card">
          <div class="card-body">
            <ContactCard :contact="activeContact" />
            <router-link
              class="mt-2 badge badge-warning d-inline-block"
              :to="{
                name: 'contact.edit',
                params: { id: activeContact._id },
              }"
            >
              <i class="fas fa-edit"></i> Hiệu chỉnh
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page {
  text-align: left;
  max-width: 900px;
  margin: 0 auto;
}

.empty-message {
  color: #6c757d;
  font-style: italic;
  padding: 1rem;
  text-align: center;
}
</style>
