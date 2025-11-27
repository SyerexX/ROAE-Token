# RoaeToken (Root Of All Evil)

> *"The love of money is the root of all evil."*

**RoaeToken (ROAE)** là dự án Smart Contract thể hiện sự nghiên cứu chuyên sâu về tiêu chuẩn ERC-20, cơ chế quản trị dòng tiền (Monetary Policy) và bảo mật Web3.

Dự án này bao gồm hai phiên bản hợp đồng, đại diện cho hai giai đoạn tư duy phát triển phần mềm: **Hiểu bản chất (Core)** và **Tối ưu hóa (Production)**.

---

## Cấu trúc Dự án

Dự án được chia làm 2 phiên bản để so sánh và đối chiếu:

### 1. `Roae-Basic.sol` (The Core)
* **Triết lý:** "Don't trust, verify". Viết lại toàn bộ logic từ con số 0 mà không dùng thư viện ngoài.
* **Mục đích:**
    * Hiểu sâu về cách EVM xử lý `mapping`, `storage slots`.
    * Tự triển khai logic toán học của `transfer`, `approve`, `transferFrom`.
    * Xây dựng cơ chế **Faucet (Vòi tiền)** thủ công với logic kiểm soát thời gian (`block.timestamp`).
* **Tính năng độc đáo:**
    * `FreeTokenDaily()`: Cơ chế nhận token miễn phí mỗi 24h (Logic Cooldown).
    * `burn()`: Cơ chế giảm phát thủ công.

### 2. `Roae-Pro.sol` (The Shield)
* **Triết lý:** "Stand on the shoulders of giants". Sử dụng thư viện chuẩn **OpenZeppelin**.
* **Mục đích:** Tối ưu hóa cho môi trường Production, đảm bảo bảo mật tuyệt đối và tiết kiệm Gas.
* **Tính năng nâng cao (Enterprise Grade):**
    * **ERC20Permit:** Hỗ trợ "Gasless Approval" (Ký giao dịch không tốn phí Gas - EIP-2612).
    * **ERC20Capped:** Giới hạn tổng cung cứng (Hard Cap) để chống lạm phát vô hạn.
    * **Pausable:** Cơ chế "Đóng băng khẩn cấp" toàn bộ hệ thống khi phát hiện tấn công.
    * **Access Control:** Quản lý quyền Admin chặt chẽ.

---

## Tính năng Kỹ thuật (Technical Highlights)

| Tính năng | Phiên bản Basic | Phiên bản Super (Pro) |
| :--- | :--- | :--- |
| **Standard ERC-20** | ✅ Tự triển khai | ✅ OpenZeppelin v5.0 |
| **Access Control** | `onlyOwner` (Custom Modifier) | `Ownable` Library |
| **Deflationary** | ✅ Hàm `burn` thủ công | ✅ `ERC20Burnable` |
| **Security** | Checks-Effects-Interactions | Standard Library Audit |
| **Emergency Stop** | ❌ | ✅ `Pausable` |
| **Gasless Tx** | ❌ | ✅ `ERC20Permit` |
| **Faucet Logic** | ✅ `FreeTokenDaily` | ❌ (Removed for security) |

---

## Hướng dẫn Deploy & Test

Dự án này tương thích với **Remix IDE** và **Hardhat**.

### Cách 1: Dùng Remix IDE (Nhanh nhất)
1.  Truy cập [Remix Ethereum](https://remix.ethereum.org).
2.  Tạo file mới và copy code từ `RoaeToken_Basic.sol` hoặc `SuperRoaeToken.sol`.
3.  Compile với phiên bản `Solidity ^0.8.0`.
4.  Tại tab Deploy:
    * Chọn **Injected Provider - MetaMask** (nếu muốn test trên Sepolia).
    * Nhập `initialSupply` (Ví dụ: 1000000).
5.  Bấm **Transact**.

### Cách 2: Tương tác (Sau khi Deploy)
* **Lấy Token miễn phí:** Gọi hàm `FreeTokenDaily()` (Chỉ bản Basic).
* **Đốt tiền:** Gọi hàm `burn(amount)`.
* **Chuyển tiền:** Gọi hàm `transfer(to, amount)`.

---

## Tác giả

**SyerexX** - *Web3 Security Researcher & Smart Contract Developer*

* Tôi tập trung vào việc thấu hiểu dòng chảy của tiền trong EVM và các lỗ hổng bảo mật tiềm ẩn (Reentrancy, Overflow, Access Control).
* Dự án này là minh chứng cho việc chuyển đổi từ tư duy "Coder" sang tư duy "Auditor".

---

> *Code is Law. But Security is Survival.*
