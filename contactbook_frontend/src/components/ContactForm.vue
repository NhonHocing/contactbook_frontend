<script>
import { Form, Field, ErrorMessage } from "vee-validate";
import * as yup from "yup";

export default {
  name: "ContactForm",
  components: {
    Form,
    Field,
    ErrorMessage,
  },
  props: {
    contact: { type: Object, required: true },
  },
  emits: ["submit:contact", "delete:contact", "cancel"],
  data() {
    return {
      contactLocal: { ...this.contact },
    };
  },
  watch: {
    contact: {
      deep: true,
      handler(newVal) {
        this.contactLocal = { ...newVal };
      },
    },
  },
  computed: {
    contactFormSchema() {
      return yup.object().shape({
        name: yup
          .string()
          .required("Tên phải có giá trị.")
          .min(2, "Tên phải ít nhất 2 ký tự.")
          .max(50, "Tên có nhiều nhất 50 ký tự."),
        email: yup
          .string()
          .email("E-mail không đúng.")
          .max(50, "E-mail tối đa 50 ký tự."),
        address: yup.string().max(100, "Địa chỉ tối đa 100 ký tự."),
        phone: yup
          .string()
          .matches(
            /((09|03|07|08|05)+([0-9]{8})\b)/g,
            "Số điện thoại không hợp lệ."
          ),
        favorite: yup.boolean(),
      });
    },
  },
  methods: {
    submitContact() {
      this.$emit("submit:contact", { ...this.contactLocal });
    },
    deleteContact() {
      this.$emit("delete:contact", { ...this.contactLocal });
    },
    cancel() {
      this.$emit("cancel");
    },
  },
};
</script>

<template>
  <div class="card-container card">
    <img
      src="https://www.gravatar.com/avatar/?d=mp&s=96"
      class="profile-img-card"
      alt="profile"
    />

    <Form @submit="submitContact" :validation-schema="contactFormSchema">
      <div class="form-group">
        <label for="name">Tên</label>
        <Field
          id="name"
          name="name"
          type="text"
          class="form-control"
          v-model="contactLocal.name"
        />
        <ErrorMessage name="name" class="error-feedback" />
      </div>

      <div class="form-group">
        <label for="email">E-mail</label>
        <Field
          id="email"
          name="email"
          type="email"
          class="form-control"
          v-model="contactLocal.email"
        />
        <ErrorMessage name="email" class="error-feedback" />
      </div>

      <div class="form-group">
        <label for="address">Địa chỉ</label>
        <Field
          id="address"
          name="address"
          type="text"
          class="form-control"
          v-model="contactLocal.address"
        />
        <ErrorMessage name="address" class="error-feedback" />
      </div>

      <div class="form-group">
        <label for="phone">Điện thoại</label>
        <Field
          id="phone"
          name="phone"
          type="tel"
          class="form-control"
          v-model="contactLocal.phone"
        />
        <ErrorMessage name="phone" class="error-feedback" />
      </div>

      <div class="form-group form-check">
        <Field
          id="favorite"
          name="favorite"
          type="checkbox"
          class="form-check-input"
          v-model="contactLocal.favorite"
        />
        <label class="form-check-label" for="favorite">
          Liên hệ yêu thích
        </label>
      </div>

      <div class="form-group d-flex gap-2 mt-3">
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-save"></i> Lưu
        </button>

        <button
          v-if="contactLocal && contactLocal._id"
          type="button"
          class="ml-2 btn btn-danger"
          @click="deleteContact"
        >
          Xóa
        </button>

        <button type="button" class="ml-2 btn btn-danger" @click="cancel">
          Thoát
        </button>
      </div>
    </Form>
  </div>
</template>


