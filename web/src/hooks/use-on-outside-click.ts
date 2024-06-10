import { useCallback, useEffect, useRef } from "react";

export const useOnOutsideClick = (onOutsideClick: EventListener) => {
  const ref = useRef(null);

  const handleClick = useCallback(
    (event: Event) => {
      // @ts-ignore
      if (ref.current && !ref.current.contains(event.target)) {
        onOutsideClick(event);
      }
    },
    [onOutsideClick]
  );

  useEffect(() => {
    document.addEventListener("click", handleClick, true);

    return () => document.removeEventListener("click", handleClick, true);
  }, [handleClick]);

  return ref;
};
