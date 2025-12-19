<script>
import contactService from "@/services/contact.service";
import ContactForm from "@/components/ContactForm.vue";

export default {
  components: {
    ContactForm,
  },
  data() {
    return {
      contact: {
        name: "",
        email: "",
        address: "",
        phone: "",
        favorite: false,
      },
      message: "",
    };
  },
  methods: {
    async saveContact(contact) {
      try {
        await contactService.create(contact);
        this.message = "Liên hệ được thêm thành công.";
        // Reset form
        this.contact = {
          name: "",
          email: "",
          address: "",
          phone: "",
          favorite: false,
        };
        // Quay về trang danh bạ sau 1 giây
        setTimeout(() => {
          this.$router.push({ name: "contactbook" });
        }, 1000);
      } catch (error) {
        console.log(error);
        this.message = "Lỗi khi thêm liên hệ.";
      }
    },
    goBack() {
      this.$router.push({ name: "contactbook" });
    },
  },
};
</script>

<template>
  <div class="page container py-4">
    <div class="row">
      <div class="col-md-6 offset-md-3">
        <h4 class="mb-3">
          <i class="fas fa-plus"></i> Thêm liên hệ mới
        </h4>

        <div v-if="message" class="alert alert-success" role="alert">
          {{ message }}
        </div>

        <ContactForm
          :contact="contact"
          @submit:contact="saveContact"
          @cancel="goBack"
        />
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
</style>

