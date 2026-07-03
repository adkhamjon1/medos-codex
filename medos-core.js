// Medos core: umumiy holat, yordamchi funksiyalar va modul ulanish nuqtalari.
window.Medos = window.Medos || {};

window.Medos.state = {
  patient: null,
  diagnosisId: null,
  selectedDrugs: [],
  settings: {}
};

window.Medos.helpers = {
  byId(id) {
    return document.getElementById(id);
  },
  setText(el, value) {
    if (el) el.textContent = value;
  },
  parseWeight(value) {
    const match = String(value || "").replace(",", ".").match(/(\d+(\.\d+)?)/);
    return match ? Number(match[1]) : null;
  },
  parseAge(value) {
    const match = String(value || "").replace(",", ".").match(/(\d+(\.\d+)?)/);
    return match ? Number(match[1]) : null;
  },
  calculateAgeYears(birthdate) {
    if (!birthdate) return null;
    const date = new Date(birthdate);
    if (Number.isNaN(date.getTime())) return null;

    const today = new Date();
    let age = today.getFullYear() - date.getFullYear();
    const monthDiff = today.getMonth() - date.getMonth();
    const dayDiff = today.getDate() - date.getDate();

    if (monthDiff < 0 || (monthDiff === 0 && dayDiff < 0)) {
      age -= 1;
    }

    return age >= 0 ? age : null;
  },
  formatDose(mg) {
    if (mg == null || Number.isNaN(mg)) return "Noma'lum";
    return `${Math.round(mg * 10) / 10} mg`;
  },
  calculateDose(drug, weight, age) {
    const parsedWeight = this.parseWeight(weight);
    const parsedAge = this.parseAge(age);
    const dosing = drug && drug.dosing;

    if (!drug || !dosing) {
      return {
        status: "missing-drug",
        message: "Dori uchun doza qoidasi topilmadi."
      };
    }

    if (!parsedWeight) {
      return {
        status: "missing-weight",
        message: "Doza hisoblash uchun vazn kiriting."
      };
    }

    const minDailyDose = parsedWeight * dosing.perKgMin;
    const maxDailyDose = parsedWeight * dosing.perKgMax;
    const cappedMaxDailyDose = Math.min(maxDailyDose, dosing.maxDailyDoseMg);
    const singleDoseMin = minDailyDose / dosing.frequencyPerDay;
    const singleDoseMax = cappedMaxDailyDose / dosing.frequencyPerDay;
    const warnings = [];

    if (maxDailyDose > dosing.maxDailyDoseMg) {
      warnings.push(`Maksimal sutkalik doza ${this.formatDose(dosing.maxDailyDoseMg)} bilan cheklangan.`);
    }

    if (parsedAge != null && parsedAge < dosing.minAgeYears) {
      warnings.push(`Yosh cheklovi: kamida ${dosing.minAgeYears} yosh.`);
    }

    return {
      status: warnings.length ? "warning" : "ok",
      weightKg: parsedWeight,
      ageYears: parsedAge,
      minDailyDose,
      maxDailyDose: cappedMaxDailyDose,
      singleDoseMin,
      singleDoseMax,
      frequencyPerDay: dosing.frequencyPerDay,
      warnings
    };
  },
  formatDoseRange(min, max) {
    if (min == null || max == null || Number.isNaN(min) || Number.isNaN(max)) return "Noma'lum";
    if (Math.round(min * 10) === Math.round(max * 10)) return this.formatDose(min);
    return `${this.formatDose(min)} - ${this.formatDose(max)}`;
  }
};
