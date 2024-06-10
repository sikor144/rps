import React, { useEffect } from "react";
import Image from "next/image";
import cx from "classnames";
import closePic from "../../../public/х.svg";

import { useOnOutsideClick } from "@/hooks/use-on-outside-click";

interface ModalProps {
  children: React.ReactNode;
  className?: string;
  onClose: () => void;
  visible: boolean;
}

export const Modal: React.FC<ModalProps> = ({
  children,
  className,
  onClose,
  visible,
}) => {
  const dialogRef = useOnOutsideClick(onClose);

  useEffect(() => {
    if (visible) {
      document.body.classList.add("overflow-hidden");
    } else {
      document.body.classList.remove("overflow-hidden");
    }

    return () => {
      // Cleanup: Remove the class when component is unmounted
      document.body.classList.remove("overflow-hidden");
    };
  }, [visible]);

  if (!visible) {
    return null;
  }

  return (
    <div
      className="relative z-modal"
      aria-labelledby="modal-title"
      role="dialog"
      aria-modal="true"
    >
      <div className="fixed inset-0 bg-gray-dark bg-opacity-70 backdrop-blur-sm backdrop-opacity-100 transition-opacity" />
      <div className="fixed inset-0 z-40 flex items-center justify-center">
        <div
          className={cx(
            "relative mx-4 rounded-xl bg-white shadow-lg sm:max-w-[880px] sm:mx-auto sm:rounded-2xl sm:shadow-2xl",
            className
          )}
          ref={dialogRef}
        >
          <div
            className={cx("w-fit overflow-y-auto rounded-xl p-7 sm:p-12", {})}
          >
            <div
              className="absolute right-5 top-5 cursor-pointer text-white hover:text-blue-light"
              onClick={onClose}
            >
              <Image src={closePic} alt="Close" width={24} height={24} />
            </div>
            {children}
          </div>
        </div>
      </div>
    </div>
  );
};
