<template>
    <Head title="Register" />

    <div class="flex flex-col md:flex-row h-screen">
        <div class="hidden md:block md:w-2/3 h-full bg-cover bg-center" style="background-image: url(assets/images/background.jpg)">
        </div>
        <div class="w-full md:w-1/3 flex flex-col justify-center items-center p-6 bg-white bg-opacity-80">
            <!-- Logo Section -->
            <div class="mb-6">
                <img src="assets/images/logo.png" alt="Logo" style="height: 100px; width: auto;">
            </div>
            <!-- Card Section -->
            <v-card class="w-full max-w-lg" title="Philippine Carabao Center" subtitle="Animal Genetics Resource Information System">
                <v-card-text>
                    <form @submit.prevent="submit">

                        <div class="mb-4">
                            <v-text-field label="Name" id="name" v-model="form.name" type="text" required autofocus
                                autocomplete="name" />
                            <InputError class="mt-2" :message="form.errors.name" />
                        </div>

                        <div class="mb-4">
                            <v-text-field label="Email" id="email" v-model="form.email" type="email" required autofocus
                                autocomplete="username" />
                            <InputError class="mt-2" :message="form.errors.email" />
                        </div>


                        <div class="mb-4">
                            <v-text-field label="Password" id="password" v-model="form.password" type="password"
                                required autocomplete="current-password" />
                            <InputError class="mt-2" :message="form.errors.password" />
                        </div>
                        <div class="mb-4">
                            <v-text-field label="Confirm Password" id="password_confirmation" v-model="form.password_confirmation" type="password"
                                required autocomplete="current-password" />
                            <InputError class="mt-2" :message="form.errors.password_confirmation" />
                        </div>

                        <div v-if="$page.props.jetstream.hasTermsAndPrivacyPolicyFeature" class="mb-4">
                            <InputLabel for="terms">
                                <div class="flex items-center">
                                    <Checkbox id="terms" v-model:checked="form.terms" name="terms" required />
                                    <div class="ml-2">
                                        I agree to the <a target="_blank" :href="route('terms.show')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Terms of Service</a> and <a target="_blank" :href="route('policy.show')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">Privacy Policy</a>
                                    </div>
                                </div>
                                <InputError class="mt-2" :message="form.errors.terms" />
                            </InputLabel>
                        </div>

                        <div class="flex justify-end space-x-4">
                            <Link :href="route('login')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Already registered?
                            </Link>
                            <v-btn :class="{ 'opacity-25': form.processing }" :disabled="form.processing"
                                color="primary" @click="submit()">
                                Register
                            </v-btn>
                        </div>
                    </form>
                </v-card-text>
            </v-card>
        </div>
    </div>
</template>

<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    terms: false,
});

const submit = () => {
    form.post(route('register'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};
</script>

<style scoped>
/* Add any specific styles here if needed */
</style>
