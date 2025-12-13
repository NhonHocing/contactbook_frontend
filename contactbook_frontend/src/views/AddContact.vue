<script>
import contactService from "@/services/contact.service";

export default {
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
    async saveContact() {
      try {
        await contactService.create(this.contact);
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

        <form @submit.prevent="saveContact">
          <div class="mb-3">
            <label for="name" class="form-label">Tên *</label>
            <input
              type="text"
              class="form-control"
              id="name"
              v-model="contact.name"
              required
            />
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">E-mail *</label>
            <input
              type="email"
              class="form-control"
              id="email"
              v-model="contact.email"
              required
            />
          </div>

          <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input
              type="text"
              class="form-control"
              id="address"
              v-model="contact.address"
            />
          </div>

          <div class="mb-3">
            <label for="phone" class="form-label">Điện thoại</label>
            <input
              type="tel"
              class="form-control"
              id="phone"
              v-model="contact.phone"
            />
          </div>

          <div class="mb-3 form-check">
            <input
              type="checkbox"
              class="form-check-input"
              id="favorite"
              v-model="contact.favorite"
            />
            <label class="form-check-label" for="favorite">
              Liên hệ yêu thích
            </label>
          </div>

          <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">
              <i class="fas fa-save"></i> Lưu
            </button>
            <button type="button" class="btn btn-secondary" @click="goBack">
              <i class="fas fa-arrow-left"></i> Quay lại
            </button>
          </div>
        </form>
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

