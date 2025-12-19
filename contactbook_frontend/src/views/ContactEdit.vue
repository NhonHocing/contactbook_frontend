<script>
import ContactForm from "@/components/ContactForm.vue";
import contactService from "@/services/contact.service";

export default {
  components: {
    ContactForm,
  },
  props: {
    id: { type: String, required: true },
  },
  data() {
    return {
      contact: null,
      message: "",
    };
  },
  methods: {
    async getContact(id) {
      try {
        this.contact = await contactService.get(id);
      } catch (error) {
        console.log(error);
        // Điều hướng NotFound giữ nguyên URL
        this.$router.push({
          name: "notfound",
          params: this.$route.params,
          query: this.$route.query,
          hash: this.$route.hash,
        });
      }
    },
    async updateContact(data) {
      try {
        await contactService.update(this.contact._id, data);
        alert("Liên hệ được cập nhật thành công.");
        this.$router.push({ name: "contactbook" });
      } catch (error) {
        console.log(error);
      }
    },
    async deleteContact(contact) {
      if (!confirm("Bạn muốn xóa Liên hệ này?")) return;
      try {
        await contactService.delete(contact._id);
        this.$router.push({ name: "contactbook" });
      } catch (error) {
        console.log(error);
      }
    },
    cancel() {
      this.$router.push({ name: "contactbook" });
    },
  },
  async created() {
    await this.getContact(this.id);
    this.message = "";
  },
};
</script>

<template>
  <div v-if="contact" class="page container py-4">
    <h4>Hiệu chỉnh Liên hệ</h4>

    <ContactForm
      :contact="contact"
      @submit:contact="updateContact"
      @delete:contact="deleteContact"
      @cancel="cancel"
    />

    <p v-if="message">{{ message }}</p>
  </div>
</template>

